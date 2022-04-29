//
//  CreateMenuSection.swift
//  
//
//  Created by Ahmed Mgua on 24/04/2022.
//

import Fluent

struct CreateMenuSection: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("MenuSections")
            .id()
            .field("Name", .string, .required)
            .field("Details", .string, .required)
            .field("CreatedOn", .datetime, .required)
            .field("LastModifiedOn", .datetime, .required)
            .unique(on: "Name")
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("MenuSections")
            .delete()
    }
}
