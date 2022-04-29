//
//  CreateFood.swift
//  
//
//  Created by Ahmed Mgua on 24/04/2022.
//

import Fluent

struct CreateFood: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("Food")
            .id()
            .field("Name", .string, .required)
            .field("Details", .string, .required)
            .field("Price", .double, .required)
            .field("ImageURL", .string, .required)
            .field("CreatedOn", .datetime, .required)
            .field("LastModifiedOn", .datetime, .required)
            .field("MenuSection", .uuid, .required, .references("MenuSections", "id", onDelete: .cascade))
        
            .unique(on: "Name")
        
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("Food")
            .delete()
    }
}
