//
//  Option+Fields.swift
//  
//
//  Created by Ahmed Mgua on 10/05/2022.
//

import Fluent

public extension Option {
    
    /// The fields in the `Option` model.
    enum Fields: FieldKey, FieldKeyRepresentable {
        case id = "id",
             name = "Name",
             priceDifference = "PriceDifference",
             optionGroupID = "OptionGroupID",
             createdOn = "CreatedOn",
             lastModifiedOn = "LastModifiedOn"
    }
}
