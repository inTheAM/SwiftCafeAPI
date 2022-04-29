//
//  File.swift
//  
//
//  Created by Ahmed Mgua on 20/04/2022.
//

import Fluent
import Vapor
struct UsersController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let usersRoute = routes.grouped("api", "users")
        let sessionRoute = routes.grouped("api", "users", "session")
        
        usersRoute.post("email", use: emailAvailabilityHandler)
        usersRoute.post("", use: signUpHandler)
        
        let basicAuthMiddleware = User.authenticator()
        let basicAuthGroup = usersRoute.grouped(basicAuthMiddleware)
        let basicSessionGroup = sessionRoute.grouped(basicAuthMiddleware)
        basicAuthGroup.get(":userID", use: getHandler)
        basicSessionGroup.post("", use: signInHandler)
        
        let tokenAuthMiddleware = Token.authenticator()
        let guardAuthMiddleware = User.guardMiddleware()
        let sessionAuthGroup = sessionRoute.grouped(tokenAuthMiddleware, guardAuthMiddleware)
        sessionAuthGroup.delete("", use: signOutHandler)
        
        let usersAuthGroup = usersRoute.grouped(tokenAuthMiddleware, guardAuthMiddleware)
        usersAuthGroup.delete("", use: deleteHandler)
    }
    
    func emailAvailabilityHandler(_ req: Request) async throws -> User.EmailCheckResult.APIResult {
        let validateData = try req.content.decode(User.ValidateData.self)
        let user = try await User.query(on: req.db)
            .filter(\.$email == validateData.email)
            .first()
        
        return User.EmailCheckResult(isAvailable: user == nil).convertToResult()
    }
    
    
    
    func signUpHandler(_ req: Request) async throws -> Token.Payload.APIResult {
        let createData = try req.content.decode(User.CreateData.self)
        let password = try Bcrypt.hash(createData.password)
        let user = User(email: createData.email, password: password)
        try await user.save(on: req.db)
        
        guard let savedUser = try await User.query(on: req.db)
            .filter(\.$email == createData.email)
            .first()
        else {
            print("USER NOT SAVED")
            throw Abort(.internalServerError)
        }
        
        let cart = Cart(userID: savedUser.id!)
        
        do { try await cart.save(on: req.db) }
        catch {
            try await savedUser.delete(on: req.db)
            print("FAILED TO CREATE CART")
            throw Abort(.internalServerError)
        }
        
        guard let token = try? Token.generate(for: savedUser) else {
            try await savedUser.delete(on: req.db)
            print("FAILED TO GENERATE TOKEN")
            throw Abort(.internalServerError)
        }
        
        do { try await token.save(on: req.db) }
        catch {
            try await savedUser.delete(on: req.db)
            print("FAILED TO SAVE TOKEN. ERROR: ", error)
            throw Abort(.internalServerError)
        }
        return token.convertToResult()
    }
    
    func signInHandler(_ req: Request) async throws -> Token.Payload.APIResult {
        let user = try req.auth.require(User.self)
        let token = try Token.generate(for: user)
        try await token.save(on: req.db)
        return token.convertToResult()
    }
    
    func signOutHandler(_ req: Request) async throws -> User.AuthResult.APIResult {
        let user = try req.auth.require(User.self)
        guard let userID = user.id else {
            throw Abort(.notFound)
        }
        guard let savedToken = try await Token.query(on: req.db)
            .filter(\.$user.$id == userID)
            .first()
        else {
            throw Abort(.notFound)
        }
            
        try await  savedToken.delete(on: req.db)
        let result = User.AuthResult.success.convertToResult()
        return result
    }
    
    func deleteHandler(_ req: Request) async throws -> User.AuthResult.APIResult {
        let reqUser = try req.auth.require(User.self)
        let userID = try reqUser.requireID()
        guard let savedUser = try await User.find(userID, on: req.db)
        else {
            throw Abort(.notFound)
        }
        try await savedUser.delete(on: req.db)
        return User.AuthResult.success.convertToResult()
    }
    
    func getHandler(_ req: Request) async throws -> User.Payload.APIResult {
        let userID = req.parameters.get("userID", as: UUID.self)
        guard let savedUser = try await User.find(userID, on: req.db)
        else {
            throw Abort(.notFound)
        }
        return savedUser.convertToResult()
    }
}

