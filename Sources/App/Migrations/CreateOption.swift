//
//  File.swift
//  
//
//  Created by Ahmed Mgua on 28/04/2022.
//

import Fluent

/// Creates/Removes the `"Options"` table in the database.
public struct CreateOption: Migration {
    
    public typealias Fields = Option.Fields
    public func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Option.schema)
            .id()
            .field(Fields.name.key, .string, .required)
            .field(Fields.priceDifference.key, .double, .required)
            .field(Fields.createdOn.key, .datetime, .required)
            .field(Fields.lastModifiedOn.key, .datetime, .required)
            .field(Fields.optionGroupID.key, .uuid, .required, .references(OptionGroup.schema, .id, onDelete: .cascade))
            .unique(on: .id)
            .create()
    }
    
    public func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("Options")
            .delete()
    }
}
