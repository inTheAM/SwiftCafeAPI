//
//  CreateToken.swift
//  
//
//  Created by Ahmed Mgua on 20/04/2022.
//

import Fluent

struct CreateToken: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("Tokens")
            .id()
            .field("Value", .string, .required)
            .field("CreatedOn", .datetime, .required)
            .field("LastModifiedOn", .datetime, .required)
            .field("UserID", .uuid, .required, .references("Users", "id", onDelete: .cascade))
            .unique(on: "UserID")
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("Tokens")
            .delete()
    }
}
