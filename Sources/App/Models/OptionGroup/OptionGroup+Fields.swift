//
//  File.swift
//  
//
//  Created by Ahmed Mgua on 10/05/2022.
//

import Fluent

public extension OptionGroup {
    
    /// The fields in the `OptionGroup` model.
    enum Fields: FieldKey, FieldKeyRepresentable {
        case id = "id",
             name = "Name",
             foodID = "FoodID",
             createdOn = "CreatedOn",
             lastModifiedOn = "LastModifiedOn"
    }
}
