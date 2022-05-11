//
//  CreateFood.swift
//  
//
//  Created by Ahmed Mgua on 24/04/2022.
//
import Vapor
import Fluent

/// Creates/Removes the `Food` table in the database.
public struct CreateFood: Migration {
    
    typealias Fields = Food.Fields
    
    public func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Food.schema)
            .id()
            .field(Fields.name.key, .string, .required)
            .field(Fields.details.key, .string, .required)
            .field(Fields.price.key, .double, .required)
            .field(Fields.imageURL.key, .string, .required)
            .field(Fields.createdOn.key, .datetime, .required)
            .field(Fields.lastModifiedOn.key, .datetime, .required)
            .field(Fields.sectionID.key, .uuid, .required, .references(MenuSection.schema, .id, onDelete: .cascade))
            .unique(on: .id, Fields.name.key)
            .create()
    }
    
    public func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("Food")
            .delete()
    }
}
