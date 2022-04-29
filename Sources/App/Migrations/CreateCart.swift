//
//  CreateCart.swift
//  
//
//  Created by Ahmed Mgua on 20/04/2022.
//

import Fluent
import Vapor

struct CreateCart: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("Carts")
            .id()
            .field("UserID", .uuid, .required, .references("Users", "id", onDelete: .cascade))
            .field("CreatedOn", .datetime, .required)
            .field("LastModifiedOn", .datetime, .required)
            .create()
        
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("Carts")
            .delete()
    }
}
