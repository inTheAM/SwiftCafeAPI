//
//  OptionGroup.swift
//  
//
//  Created by Ahmed Mgua on 20/04/2022.
//

import Fluent
import Vapor

public final class OptionGroup: Model {
    
    /// The name of the database table in which the `OptionGroup`s will be stored.
    ///
    /// Conformance to `FluentKit.Schema`
    public static let schema: String = "OptionGroups"
    
    /// The id of the option group in the database.
    ///
    /// Conformance to `FluentKit.Model`.
    @ID(key: .id)
    public var id: UUID?
    
    /// The name of the option group.
    @Field(key: Fields.name.key)
    public var name: String
    
    /// The food the option group belongs to.
    /// Created as a one-one relationship between the `"Foods"` table and the `"OptionGroups"` table in
    /// the database since each `OptionGroup` can only appear once in each `Food`.
    @Parent(key: Fields.foodID.key)
    public var food: Food
    
    /// The options this option group contains.
    /// Created as a one-many relationship between the `"OptionGroups"` table and the `"Options"` table
    /// in the database since each `Option` can only be in one `OptionGroup`.
    @Children(for: \.$optionGroup)
    public var options: [Option]
    
    /// The time the option group was created.
    @Timestamp(key: Fields.createdOn.key, on: .create)
    public var createdOn: Date?
    
    /// The time the option group was last modified.
    @Timestamp(key: Fields.lastModifiedOn.key, on: .update)
    public var lastModifiedOn: Date?
    
    /// Conformance to `FluentKit.Model`.
    public init() {}
    
    
    /// Creates an `OptionGroup`
    /// - Parameters:
    ///   - id: The id to save the option group with in the database.
    ///         Default `nil` value will automatically create an id for the new entry in the database.
    ///   - name: The name of the option group.
    ///   - foodID: The food this option group is linked to.
    public init(id: UUID? = nil, name: String, foodID: Food.IDValue) {
        self.id = id
        self.name = name
        self.$food.id = foodID
    }
}








