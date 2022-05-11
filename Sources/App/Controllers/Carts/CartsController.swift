//
//  CartsController.swift
//
//
//  Created by Ahmed Mgua on 06/05/2022.
//

import Fluent
import Vapor

public struct CartsController: RouteCollection {
    public func boot(routes: RoutesBuilder) throws {
        let cartRoutes = routes.grouped("api", "carts")
        
        let tokenAuthMiddleware = Token.authenticator()
        let guardAuthMiddleware = User.guardMiddleware()
        let protectedRoute = cartRoutes.grouped(tokenAuthMiddleware, guardAuthMiddleware)
    }
    
}


