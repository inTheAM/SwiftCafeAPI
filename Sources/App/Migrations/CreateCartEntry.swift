//
//  CreateCartEntry.swift
//  
//
//  Created by Ahmed Mgua on 24/04/2022.
//

import Fluent
import Vapor

struct CreateCartEntry: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("CartEntries")
            .id()
            .field("Quantity", .int, .required)
            .field("CreatedOn", .datetime, .required)
            .field("LastModifiedOn", .datetime, .required)
            .field("CartID", .uuid, .required, .references("Carts", "id", onDelete: .cascade))
            .field("FoodID", .uuid, .required, .references("Food", "id", onDelete: .cascade))
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("CartEntries")
            .delete()
    }
}
