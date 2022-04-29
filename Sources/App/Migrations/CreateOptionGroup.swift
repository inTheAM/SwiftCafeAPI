//
//  CreateOptionGroup.swift
//  
//
//  Created by Ahmed Mgua on 28/04/2022.
//

import Fluent

struct CreateOptionGroup: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("OptionGroups")
            .id()
            .field("Name", .string, .required)
            .field("CreatedOn", .datetime, .required)
            .field("LastModifiedOn", .datetime, .required)
            .field("FoodID", .uuid, .required, .references("Food", "id", onDelete: .cascade))
            .unique(on: .id)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("OptionGroups")
            .delete()
    }
}
