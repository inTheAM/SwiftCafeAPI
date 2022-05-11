//
//  File.swift
//  
//
//  Created by Ahmed Mgua on 20/04/2022.
//

import Fluent
import Vapor

/// Route collection for accessing user-related and session resources.
public struct UsersController: RouteCollection {
    /// Sets up the endpoints for the User resources.
    /// - Parameter routes: The `RoutesBuilder` used to build the routes.
    public func boot(routes: RoutesBuilder) throws {
        // Setting up authorization middleware
        let basicAuthMiddleware = User.authenticator()
        let guardAuthMiddleware = User.guardMiddleware()
        let tokenAuthMiddleware = Token.authenticator()
        
        // User resources route
        let usersRoute = routes.grouped("api", "users")
        
        // Creating email availability checks and sign-up routes as open endpoints
        usersRoute.post("email", use: emailAvailabilityHandler)
        usersRoute.post("", use: signUpHandler)
        
        // Creating account deletion and user details routes using token authorization
        let usersAuthGroup = usersRoute.grouped(tokenAuthMiddleware, guardAuthMiddleware)
        usersAuthGroup.delete("", use: deleteHandler)
        usersAuthGroup.get(":userID", use: getHandler)
        
        
        // Session route
        let sessionRoute = routes.grouped("api", "users", "session")
        
        // Creating sign-in route using basic authorization
        let basicSessionGroup = sessionRoute.grouped(basicAuthMiddleware)
        basicSessionGroup.post("", use: signInHandler)
        
        // Creating sign-out route using token authorization
        let sessionAuthGroup = sessionRoute.grouped(tokenAuthMiddleware, guardAuthMiddleware)
        sessionAuthGroup.delete("", use: signOutHandler)
        
    }
    
    /// Checks whether an email address is associated with any user in the database. 
    /// - Parameter req: The request received.
    /// - Returns: A RequestResult representing an available or unavailable email address
    public func emailAvailabilityHandler(_ req: Request) async throws -> EmailCheckResult.APIResult {
        // Getting the email address from the request body
        let emailCheckData = try req.content.decode(EmailCheckData.self)
        
        // Checking for a user associated with the email address
        let user = try await User.query(on: req.db)
            .filter(\.$email == emailCheckData.email)
            .first()
        
        let result: EmailCheckResult
        if user == nil {
            result = .init(isAvailable: true)
        } else {
            result = .init(isAvailable: false)
        }
        return result.convertToResult()
    }
    
    /// Creates an account, a cart and a session for a new user.
    /// - Parameter req: The request received.
    /// - Returns: The token generated for the new user's session.
    public func signUpHandler(_ req: Request) async throws -> Token.Payload.APIResult {
        // Getting the user data from the request
        let createData = try req.content.decode(NewUserData.self)
        
        // Creating a hash of the password to store in the database
        let password = try Bcrypt.hash(createData.password)
        
        // Creating the new user and saving on the database
        let user = User(email: createData.email, password: password)
        try await user.save(on: req.db)
        
        guard let savedUser = try await User.query(on: req.db)
            .filter(\.$email == createData.email)
            .first()
        else {
            print("USER NOT SAVED")
            throw Abort(.internalServerError)
        }
        
        // Creating a cart for the new user and saving on the database.
        let cart = Cart(userID: savedUser.id!)
        
        do { try await cart.save(on: req.db) }
        
        // If cart creation fails, delete the user from the database.
        // A user cannot exist without a cart
        catch {
            try await savedUser.delete(on: req.db)
            print("FAILED TO CREATE CART")
            throw Abort(.internalServerError)
        }
        
        // Creating a token for the new user to automatically sign in and saving to the database
        guard let token = try? Token.generate(for: savedUser) else {
            try await savedUser.delete(on: req.db)
            print("FAILED TO GENERATE TOKEN")
            throw Abort(.internalServerError)
        }
        
        do { try await token.save(on: req.db) }
        catch {
            // If the token could not be saved,
            // delete the user from the database to re-attempt sign-up
            try await savedUser.delete(on: req.db)
            print("FAILED TO SAVE TOKEN. ERROR: ", error)
            throw Abort(.internalServerError)
        }
        
        // Returning the token wrapped in a result
        return token.convertToPayload().convertToResult()
    }
    
    /// Starts a new session for a user by generating a token.
    /// - Parameter req: The request received.
    /// - Returns: The token created for the user's new session.
    public func signInHandler(_ req: Request) async throws -> Token.Payload.APIResult {
        let user = try req.auth.require(User.self)
        let token = try Token.generate(for: user)
        try await token.save(on: req.db)
        return token.convertToPayload().convertToResult()
    }
    
    /// Ends the active session for the user by deleting the token saved on the database.
    /// - Parameter req: The request received
    /// - Returns: A RequestResult indicating whether the sign-out operation was successful or not.
    public func signOutHandler(_ req: Request) async throws -> HTTPStatus {
        let user = try req.auth.require(User.self)
        guard let userID = try? user.requireID() else {
            throw Abort(.internalServerError)
        }
        guard let savedToken = try await Token.query(on: req.db)
            .filter(\.$user.$id == userID)
            .first()
        else {
            throw Abort(.internalServerError)
        }
            
        try await  savedToken.delete(on: req.db)
        
        return HTTPStatus.ok
    }
    
    /// Deletes the user's account.
    /// - Parameter req: The request received.
    /// - Returns: A RequestResult indicating whether the account deletion was successful or not.
    public func deleteHandler(_ req: Request) async throws -> HTTPStatus {
        let reqUser = try req.auth.require(User.self)
        let userID = try reqUser.requireID()
        
        // Getting the user from the database
        guard let savedUser = try await User.find(userID, on: req.db)
        else {
            throw Abort(.notFound)
        }
        
        // Deleting the user from the database
        try await savedUser.delete(on: req.db)
        
        // Returning a success result
        return HTTPStatus.ok
    }
    
    /// Retrieves a user's details.
    /// - Parameter req: The request received.
    /// - Returns: The user's details wrapped in a result.
    public func getHandler(_ req: Request) async throws -> User.Payload.APIResult {
        let userID = req.parameters.get("userID", as: UUID.self)
        
        // Getting the user from the database
        guard let savedUser = try await User.find(userID, on: req.db)
        else {
            throw Abort(.internalServerError)
        }
        
        // Returning the user as a result
        return savedUser.convertToPayload().convertToResult()
    }
}

