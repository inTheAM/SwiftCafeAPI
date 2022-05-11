//
//  Food+Fields.swift
//  
//
//  Created by Ahmed Mgua on 10/05/2022.
//

import Fluent

public extension Food {
    
    /// The fields in the `Food` model.
    enum Fields: FieldKey, FieldKeyRepresentable {
        case id = "id",
             name = "Name",
             details = "Details",
             price = "Price",
             imageURL = "ImageURL",
             sectionID = "MenuSectionID",
             createdOn = "CreatedOn",
             lastModifiedOn = "LastModifiedOn"
    }
}
