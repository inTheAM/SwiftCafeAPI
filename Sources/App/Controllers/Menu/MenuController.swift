//
//  MenuController.swift
//  
//
//  Created by Ahmed Mgua on 24/04/2022.
//

import Fluent
import Vapor

/// # Route collection for accessing the Menu and Food options.
public struct MenuController: RouteCollection {
    
    public func boot(routes: RoutesBuilder) throws {
        
        // Configuring the routes and adding token authorization.
        let menuRoutes = routes.grouped("api", "menu")
        let tokenAuthMiddleware = Token.authenticator()
        let guardAuthMiddleware = User.guardMiddleware()
        let menuAuthGroup = menuRoutes.grouped(tokenAuthMiddleware, guardAuthMiddleware)
        
        // Get menu
        menuAuthGroup.get(use: getHandler)
        
        // Get the options for a specific food
        menuAuthGroup.get("options", ":foodID", use: getOptionsHandler)
    }
    
    /// Handles a `GET` request for the menu.
    /// Authorization required.
    /// - Parameter req: The request received.
    /// - Returns: An array of menu sections.
    public func getHandler(_ req: Request) async throws -> NetworkResponse<[MenuSection.Payload]> {
        // Authorizing the user
        let _ = try req.auth.require(User.self)
        
        // Getting the sections from the database
        let sections = try await MenuSection.query(on: req.db)
            .all()
            .map { section in
                // Getting the food items in each section and converting them to paylaods
                section.$items.get(on: req.db)
                    .map { items in
                         items.map { $0.convertToPayload() }
                    }
                    .map { payloadItems in
                        // Using the payload items to convert the section to payload
                        section.convertToPayload(items: payloadItems)
                    }
            }
            .flatten(on: req.eventLoop)
            .get()
        
        // Returning payload sections wrapped as a result
        return sections.convertToResult()
    }
    
    public func getOptionsHandler(_ req: Request) async throws -> NetworkResponse<[OptionGroup.Payload]> {
        let _ = try req.auth.require(User.self)
        
        // Getting, from the request, the id of the food for which options are being requested
        guard let foodID = req.parameters.get("foodID", as: UUID.self)
        else { throw Abort(.notFound) }
        
        // Getting the option groups for the food item
        let foodOptionGroups = try await OptionGroup.query(on: req.db)
            .filter(\.$food.$id == foodID)
            .all()
            .map { group in
                // Getting the options in each group and converting them to payloads
                group.$options.get(on: req.db)
                    .map { options in
                        options.map { $0.convertToPayload() }
                    }
                    .map { payloadOptions in
                        // Using the payload options to convert the group to a payload
                        group.convertToPayload(options: payloadOptions)
                    }
            }
            .flatten(on: req.eventLoop)
            .get()
        
        // Returning the option groups wrapped in a result
        return foodOptionGroups.convertToResult()
    }
}
