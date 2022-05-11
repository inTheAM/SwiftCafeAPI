//
//  CreateCartEntry.swift
//  
//
//  Created by Ahmed Mgua on 24/04/2022.
//

import Fluent

/// Creates/Removes the `CartEntries` table in the database.
public struct CreateCartEntry: Migration {
    typealias Fields = CartEntry.Fields
    
    public func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(CartEntry.schema)
            .id()
            .field(Fields.quantity.key, .int, .required)
            .field(Fields.createdOn.key, .datetime, .required)
            .field(Fields.lastModifiedOn.key, .datetime, .required)
            .field(Fields.cartID.key, .uuid, .required, .references(Cart.schema, .id, onDelete: .cascade))
            .field(Fields.foodID.key, .uuid, .required, .references(Food.schema, .id, onDelete: .cascade))
            .unique(on: .id)
            .create()
    }
    
    public func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(CartEntry.schema)
            .delete()
    }
}
