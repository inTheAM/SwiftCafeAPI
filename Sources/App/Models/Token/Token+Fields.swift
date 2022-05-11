//
//  Token+Fields.swift
//  
//
//  Created by Ahmed Mgua on 11/05/2022.
//

import Fluent

public extension Token {
    
    /// The fields in the `Token` model.
    enum Fields: FieldKey, FieldKeyRepresentable {
        case id = "id",
             value = "Value",
             userID = "UserID",
             createdOn = "CreatedOn",
             lastModifiedOn = "LastModifiedOn"
    }
}
