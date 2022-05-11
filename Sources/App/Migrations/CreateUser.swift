//
//  CreateUser.swift
//  
//
//  Created by Ahmed Mgua on 20/04/2022.
//

import Fluent

/// # Creates/Removes the `"Users"` table in the database.
public struct CreateUser: Migration {
    
    public typealias Fields = User.Fields
    
    public func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(User.schema)
            .id()
            .field(Fields.email.key, .string, .required)
            .field(Fields.password.key, .string, .required)
            .field(Fields.createdOn.key, .datetime, .required)
            .field(Fields.lastModifiedOn.key, .datetime, .required)
            .unique(on: .id, Fields.email.key)
            .create()
    }
    
    public func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("Users")
            .delete()
    }
}
