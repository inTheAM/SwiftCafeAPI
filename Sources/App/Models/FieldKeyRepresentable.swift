//
//  File.swift
//  
//
//  Created by Ahmed Mgua on 10/05/2022.
//

import Fluent

/// A protocol for enums used to create the `FieldKey` for `Model` properties.
///
/// Improves readability and reduces string literal usage in `FieldKey` creation.
///
/// Create a conforming enum with cases containing the string literal values in one place:
///
///     extension MyModel {
///         enum Fields: FieldKey, FieldKeyRepresentable {
///             case name = "Name"
///         }
///     }
///
/// Use the enum cases in multiple places e.g
///
/// To create fields in models;
///
///     @Field(key: Fields.name.key)
///     var name: String
///
/// In migrations to reference fields;
///
///     database.schema(MyModel.schema)
///         .id()
///         .field(MyModel.Fields.name.key, .string, .required)

public protocol FieldKeyRepresentable: RawRepresentable where RawValue == FieldKey {
    var key: FieldKey {get}
}

extension FieldKeyRepresentable {
    
    /// Returns the raw value of the conforming enum case.
    /// Improves readability and communicates that the raw value is a `FieldKey`.
    ///
    /// This reads better:
    ///
    ///     @Field(key: Fields.name.key)
    ///     var name: String
    ///
    /// than:
    ///
    ///     @Field(key: Fields.name.rawValue)
    ///     var name: String
    public var key: FieldKey {
        self.rawValue
    }
}
