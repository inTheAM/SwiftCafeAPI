//
//  File.swift
//  
//
//  Created by Ahmed Mgua on 10/05/2022.
//

import Fluent

public extension MenuSection {
    
    /// The fields in the `MenuSection` model.
    enum Fields: FieldKey, FieldKeyRepresentable {
        case id = "id",
             name = "Name",
             details = "Details",
             createdOn = "CreatedOn",
             lastModifiedOn = "LastModifiedOn"
    }
}
