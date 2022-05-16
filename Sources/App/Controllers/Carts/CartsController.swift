//
//  CartsController.swift
//
//
//  Created by Ahmed Mgua on 06/05/2022.
//

import Fluent
import Vapor
import CloudKit

public struct CartsController: RouteCollection {
    public func boot(routes: RoutesBuilder) throws {
        let cartRoutes = routes.grouped("api", "carts")
        
        let tokenAuthMiddleware = Token.authenticator()
        let guardAuthMiddleware = User.guardMiddleware()
        let protectedRoute = cartRoutes.grouped(tokenAuthMiddleware, guardAuthMiddleware)
        
        protectedRoute.get(use: getHandler)
        protectedRoute.post(use: addItemHandler)
        protectedRoute.delete(use: deleteItemHandler)
    }
    
    /// Handles a `GET` request for the user's cart.
    /// - Parameter req: The request received.
    /// - Returns: The user's cart as a payload.
    func getHandler(_ req: Request) async throws -> Cart.Payload.APIResult {
        let user = try req.auth.require(User.self)
        
        guard let userID = user.id
        else { throw Abort(.internalServerError) }
        
        let cart = try await Cart.query(on: req.db)
            .filter(\.$user.$id == userID)
            .first()
            .unwrap(or: Abort(.internalServerError))
            .get()
        guard let cartID = cart.id
        else { throw Abort(.internalServerError) }
        
        // Getting all cart entries
        let cartEntries = try await CartEntry.query(on: req.db)
            .filter(\.$cart.$id == cartID)
            .all()
            .map { entry in
                
                // Getting the selected food in the entry
                entry.$food.get(on: req.db)
                    .map { food in
                        food.convertToPayload()
                    }
                    .flatMap { foodPayload in
                        
                        // Getting the selected options in the entry
                        entry.$options.get(on: req.db)
                            .map { options in
                                options.map { $0.convertToPayload() }
                            }
                        // Converting to payload
                            .map { optionPayloads in
                                return entry.convertToPayload(food: foodPayload, options: optionPayloads)
                            }
                    }
                
            }
            .flatten(on: req.eventLoop)
            .get()
        
        
        return cart.convertToPayload(contents: cartEntries).convertToResult()
    }
    
    /// Adds an item to the user's cart.
    ///
    /// Creates a cart entry with the data received, then creates option entries for the selected options
    /// and saves everything to the database.
    /// - Parameter req: The request received.
    /// - Returns: The saved cart entry as a payload containing the selected options..
    func addItemHandler(_ req: Request) async throws -> CartEntry.Payload.APIResult {
        let user = try req.auth.require(User.self)
        
        // Decoding the sent data.
        let cartEntry = try req.content.decode(AddToCartData.self)
        
        guard let id = user.id else {
            throw Abort(.internalServerError)
        }
        
        // Getting the user's cart.
        let cartQuery = Cart.query(on: req.db)
            .filter(\.$user.$id == id)
            .first()
            .unwrap(or: Abort(.internalServerError))
        
        // Getting the selected Food.
        let foodQuery = Food.find(cartEntry.foodID, on: req.db)
            .unwrap(or: Abort(.notFound))
        
        // Getting the selected options
        let optionQueries = cartEntry.options.map { id in
            Option.query(on: req.db)
                .filter(\.$id == id)
                .first()
                .unwrap(or: Abort(.notFound))
        }.flatten(on: req.eventLoop)
        
        
        return try await cartQuery.and(foodQuery)
            .flatMap { cart, food in
                // Checking if the cart already contains the selected food.
                return cart.$contents.get(on: req.db)
                    .flatMapThrowing { contents  in
                        guard !contents.contains(where: {$0.id == food.id}) else {
                            throw Abort(.conflict)
                        }
                    }.flatMap {
                        // Creating the cart entry
                        guard let entry = try? CartEntry(quantity: cartEntry.quantity, cart: cart, food: food) else {
                            return req.eventLoop.future(error:  Abort(.internalServerError))
                        }
                        
                        // Saving the cart entry to the database.
                        // The save operation is chained with the option queries so
                        // that option entries can be created using the cart entry id, which is
                        // only set on save.
                        // Once all save operations are complete, the cart entry is sent back to
                        // the user showing the selected options.
                        return entry.save(on: req.db)
                            .and(optionQueries)
                            .map { _, options in
                                
                                // Creating option entries and saving to the database
                            options.map { option  in
                                try! OptionEntry(option: option, cartEntry: entry)
                                    .save(on: req.db)
                                    .map { _ in
                                        return option
                                    }
                            }
                        }.flatMap { options in
                            // With everything saved, convert the selected options to payloads
                            options
                                .map { options in
                                    options.map { $0.convertToPayload() }
                                }
                                .flatten(on: req.eventLoop)
                            // Combine the option payloads with the cart entry and send as a result.
                                .map { optionPayloads in
                                            entry
                                                .convertToPayload(food: food.convertToPayload(), options: optionPayloads)
                                                .convertToResult()
                                }
                        }
                    }
            }
            .get()
    }
    
    
    /// Handles deleting a cart entry from a user's cart.
    ///
    /// The cart entry id is received and the corresponding cart entry and option entries are deleted from the database.
    /// - Parameter req: The request received.
    /// - Returns: An `HTTPStatus` showing whether the deletion was successful.
    func deleteItemHandler(_ req: Request) async throws -> HTTPStatus {
        let _ = try req.auth.require(User.self)
        
        // Decoding the data sent to identify the cart entry to delete.
        let removeData = try req.content.decode(RemoveFromCartData.self)
        
        // Gets the cart entry and deletes from the database
        let deleteCartEntry = CartEntry.find(removeData.cartEntryID, on: req.db)
            .unwrap(or: Abort(.notFound))
            .map { entry in
                entry.delete(on: req.db)
            }
        
        // Gets the related option entries and deletes from the database
        let deleteOptionEntries = OptionEntry.query(on: req.db)
            .filter(\.$cartEntry.$id == removeData.cartEntryID)
            .all()
            .map { entries in
                entries.map { $0.delete(on: req.db) }
            }
        
        // Chaining the two operations and returning an ok status.
        return try await deleteCartEntry.and(deleteOptionEntries)
            .transform(to: HTTPStatus.ok)
            .get()
    }
    
}


