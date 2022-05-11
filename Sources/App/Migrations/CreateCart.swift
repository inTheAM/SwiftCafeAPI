//
//  CreateCart.swift
//  
//
//  Created by Ahmed Mgua on 20/04/2022.
//

import Fluent

/// Creates/Removes the `Carts` table in the database.
public struct CreateCart: Migration {
    
    /// The fields in the `Cart` model
    typealias Fields = Cart.Fields
    
    public func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Cart.schema)
            .id()
            .field(Fields.userID.key, .uuid, .required, .references(User.schema, .id, onDelete: .cascade))
            .field(Fields.createdOn.key, .datetime, .required)
            .field(Fields.lastModifiedOn.key, .datetime, .required)
            .unique(on: .id, Fields.userID.key)
            .create()
        
    }
    
    public func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("Carts")
            .delete()
    }
}
