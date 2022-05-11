//
//  CartEntry+Fields.swift
//  
//
//  Created by Ahmed Mgua on 10/05/2022.
//

import Fluent

public extension CartEntry {
    
    /// The string literal values of the fields in the `Cart` model.
    enum Fields: FieldKey, FieldKeyRepresentable {
        case id = "id",
             quantity = "Quantity",
             cartID = "CartID",
             foodID = "FoodID",
             createdOn = "CreatedOn",
             lastModifiedOn = "LastModifiedOn"
    }
}
