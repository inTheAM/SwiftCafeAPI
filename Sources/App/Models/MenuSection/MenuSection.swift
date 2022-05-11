//
//  File.swift
//  
//
//  Created by Ahmed Mgua on 20/04/2022.
//

import Fluent
import Vapor

/// A section of the menu containing food items for the user to add to their cart.
public final class MenuSection: Model    {
    
    /// The name of the database table in which `MenuSection`s will be stored.
    ///
    /// Conformance to `FluentKit.Schema`
    public static var schema = "MenuSections"
    
    /// The id of the section in the database.
    ///
    /// Conformance to `FluentKit.Model`.
    @ID(key: .id)
    public var id: UUID?
    
    /// The name of the section.
    @Field(key: Fields.name.key)
    public var name: String
    
    /// The description of the section.
    @Field(key: Fields.details.key)
    public var details: String
    
    /// The `Food` items in the section.
    /// 
    /// Created as a one-many relationship between the `"MenuSections"` table and the `"Food"` table in
    /// the database since a section can contain more than one food item.
    @Children(for: \.$section)
    public var items: [Food]
    
    /// The time the menu section was created.
    /// Filled automatically on creation.
    @Timestamp(key: Fields.createdOn.key, on: .create)
    public var createdOn: Date?
    
    /// The time the section was last modified.
    /// Updated automatically on modification.
    @Timestamp(key: Fields.lastModifiedOn.key, on: .update)
    public var lastModifiedOn: Date?
    
    /// Conformance to `FluentKit.Model`.
    public init(){}
    
    
    /// Creates a `MenuSection`.
    /// - Parameters:
    ///   - id: The id to save the section with in the database.
    ///         Default `nil` value will automatically create an id for the new entry in the database.
    ///   - name: The name of the section.
    ///   - details: The description of the section.
    public init(id: UUID? = nil, name: String, details: String)    {
        self.id = id
        self.name = name
        self.details = details
    }
}
