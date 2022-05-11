//
//  OptionEntry+Fields.swift
//  
//
//  Created by Ahmed Mgua on 10/05/2022.
//

import Fluent

public extension OptionEntry {
    
    /// The fields in the `OptionEntry` model.
    enum Fields: FieldKey, FieldKeyRepresentable {
        case id = "id",
             optionID = "OptionID",
             cartEntryID = "CartEntryID"
    }
}
