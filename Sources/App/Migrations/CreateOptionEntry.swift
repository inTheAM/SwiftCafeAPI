//
//  CreateOptionEntry.swift
//  
//
//  Created by Ahmed Mgua on 06/05/2022.
//

import Fluent

/// # Creates/Removes the `"OptionEntries"` table in the database.
public struct CreateOptionEntry: Migration {
    
    typealias Fields = OptionEntry.Fields
    
    public func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(OptionEntry.schema)
            .id()
            .field(Fields.cartEntryID.key, .uuid, .required, .references(CartEntry.schema, .id, onDelete: .cascade))
            .field(Fields.optionID.key, .uuid, .required, .references(Option.schema, .id, onDelete: .cascade))
            .unique(on: .id)
            .create()
    }
    
    public func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("OptionEntries")
            .delete()
    }
}
