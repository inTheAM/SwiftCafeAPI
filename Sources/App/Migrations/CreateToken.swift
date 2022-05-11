//
//  CreateToken.swift
//  
//
//  Created by Ahmed Mgua on 20/04/2022.
//

import Fluent

/// # Creates/Removes the `"Tokens"` table in the database.
public struct CreateToken: Migration {
    
    public typealias Fields = Token.Fields
    
    public func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Token.schema)
            .id()
            .field(Fields.value.key, .string, .required)
            .field(Fields.createdOn.key, .datetime, .required)
            .field(Fields.lastModifiedOn.key, .datetime, .required)
            .field(Fields.userID.key, .uuid, .required, .references(User.schema, .id, onDelete: .cascade))
            .unique(on: .id, Fields.userID.key)
            .create()
    }
    
    public func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("Tokens")
            .delete()
    }
}
