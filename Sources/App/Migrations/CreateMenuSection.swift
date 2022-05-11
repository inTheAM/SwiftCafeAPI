//
//  CreateMenuSection.swift
//  
//
//  Created by Ahmed Mgua on 24/04/2022.
//

import Fluent

/// Creates/Removes the `MenuSections` table in the database.
public struct CreateMenuSection: Migration {
    
    typealias Fields = MenuSection.Fields
    
    public func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema(MenuSection.schema)
            .id()
            .field(Fields.name.key, .string, .required)
            .field(Fields.details.key, .string, .required)
            .field(Fields.createdOn.key, .datetime, .required)
            .field(Fields.lastModifiedOn.key, .datetime, .required)
            .unique(on: .id, Fields.name.key)
            .create()
    }
    
    public func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("MenuSections")
            .delete()
    }
}
