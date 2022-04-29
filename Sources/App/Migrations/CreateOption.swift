//
//  File.swift
//  
//
//  Created by Ahmed Mgua on 28/04/2022.
//

import Fluent

struct CreateOption: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("Options")
            .id()
            .field("Name", .string, .required)
            .field("PriceDifference", .double, .required)
            .field("CreatedOn", .datetime, .required)
            .field("LastModifiedOn", .datetime, .required)
            .field("OptionGroup", .uuid, .required, .references("OptionGroups", "id", onDelete: .cascade))
            .unique(on: .id)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("Options")
            .delete()
    }
}
