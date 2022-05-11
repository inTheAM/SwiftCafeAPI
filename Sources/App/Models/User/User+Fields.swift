//
//  User+Fields.swift
//  
//
//  Created by Ahmed Mgua on 11/05/2022.
//

import Fluent

public extension User {
    
    /// The fields in the `User` model.
    enum Fields: FieldKey, FieldKeyRepresentable {
        case id = "id",
             email = "Email",
             password = "Password",
             createdOn = "CreatedOn",
             lastModifiedOn = "LastModifiedOn"
    }
}
