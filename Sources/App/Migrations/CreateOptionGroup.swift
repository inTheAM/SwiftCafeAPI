//
//  CreateOptionGroup.swift
//  
//
//  Created by Ahmed Mgua on 28/04/2022.
//

import Fluent

/// # Creates/Removes the `"OptionGroups"` table in the database.
public struct CreateOptionGroup: Migration {
    
    typealias Fields = OptionGroup.Fields
    
    public func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema(OptionGroup.schema)
            .id()
            .field(Fields.name.key, .string, .required)
            .field(Fields.createdOn.key, .datetime, .required)
            .field(Fields.lastModifiedOn.key, .datetime, .required)
            .field(Fields.foodID.key, .uuid, .required, .references(Food.schema, .id, onDelete: .cascade))
            .unique(on: .id)
            .create()
    }
    
    public func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema(OptionGroup.schema)
            .delete()
    }
}
