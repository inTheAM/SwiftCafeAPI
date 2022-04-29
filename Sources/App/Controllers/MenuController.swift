//
//  MenuController.swift
//  
//
//  Created by Ahmed Mgua on 24/04/2022.
//

import Fluent
import Vapor


struct MenuController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let menuRoutes = routes.grouped("api", "menu")
        
        let tokenAuthMiddleware = Token.authenticator()
        let guardAuthMiddleware = User.guardMiddleware()
        let menuAuthGroup = menuRoutes.grouped(tokenAuthMiddleware, guardAuthMiddleware)
        menuAuthGroup.get(use: getHandler)
        menuAuthGroup.get("options", ":foodID", use: getOptionsHandler)
//        sectionRoutes.get(":sectionID", use: getSectionHandler)
//        sectionRoutes.get(":sectionID", "items", use: getSectionItemsHandler)
//        sectionRoutes.post(use: createHandler)
//        sectionRoutes.put(":sectionID", use: updateHandler)
//        sectionRoutes.delete(":sectionID", use: deleteHandler)
    }
    
    func getHandler(_ req: Request) async throws -> NetworkResponse<[MenuSection.Payload]> {
        let _ = try req.auth.require(User.self)
        
        let sections = try await MenuSection.query(on: req.db)
            .all()
        
        let filledSections = try await sections.map { section in
            section.$items.get(on: req.db)
                .map { items in
                    items.map { item in
                        item.convertToPayload()
                    }
                }.map { items in
                    section.convertToPayload(items: items)
                }
        }
            .flatten(on: req.eventLoop)
            .get()
        
        return filledSections.convertToResult()
    }
    
    func getOptionsHandler(_ req: Request) async throws -> NetworkResponse<[OptionGroup.Payload]> {
        let _ = try req.auth.require(User.self)
        guard let foodID = req.parameters.get("foodID", as: UUID.self)
        else { throw Abort(.notFound) }
        let foodOptionGroups = try await OptionGroup.query(on: req.db)
            .filter(\.$food.$id == foodID)
            .all()
        let allOptions = try await Option.query(on: req.db)
            .all()
        print("ALL OPTIONS: ", allOptions)
        let foodOptions = try await foodOptionGroups.map { group in
            group.$options.get(on: req.db)
                .map { options in
                    print("OPTIONS: ", options)
                    return options.map { option in
                        option.convertToPayload()
                    }
                }.map { options in
                    group.convertToPayload(options: options)
                }
        }
            .flatten(on: req.eventLoop)
            .get()
        print(foodOptions)
        return foodOptions.convertToResult()
    }
}
