//
//  Cart+Fields.swift
//  
//
//  Created by Ahmed Mgua on 09/05/2022.
//

import Fluent

public extension Cart {
    
    /// The fields in the `Cart` model.
    enum Fields: FieldKey, FieldKeyRepresentable {
        case id = "id",
             userID = "UserID",
             createdOn = "CreatedOn",
             lastModifiedOn = "LastModifiedOn"
    }
}
