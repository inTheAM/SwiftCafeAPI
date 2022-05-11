//
//  File.swift
//  
//
//  Created by Ahmed Mgua on 06/05/2022.
//

import Fluent
import Vapor

public final class Option: Model {
    
    public typealias PriceDifference = Double
    
    /// The name of the database table in which the `Option`s will be stored.
    ///
    /// Conformance to `FluentKit.Schema`
    public static let schema: String = "Options"
    
    /// The id of the option in the database.
    ///
    /// Conformance to `FluentKit.Model`.
    @ID(key: .id)
    public var id: UUID?
    
    /// The name of the option.
    @Field(key: Fields.name.key)
    public var name: String
    
    /// The price difference this option adds to the base price of the food this option belongs to.
    @Field(key: Fields.priceDifference.key)
    public var priceDifference: Double
    
    /// The `OptionGroup` this option belongs in.
    ///
    /// Created as a one-many relationship between the `"OptionGroups"` table and the `"Options"` table in
    /// the database since each option group can have multiple options.
    @Parent(key: Fields.optionGroupID.key)
    public var optionGroup: OptionGroup
    
    /// The time the option was created.
    /// Filled in automatically on creation.
    @Timestamp(key: Fields.createdOn.key, on: .create)
    public var createdOn: Date?
    
    /// The time the option was last modified.
    /// Filled in / Updated automatically on modification.
    @Timestamp(key: Fields.lastModifiedOn.key, on: .update)
    public var lastModifiedOn: Date?
    
    /// Conformance to `FluentKit.Model`.
    public init() {}
    
    
    /// Initializes an `Option`.
    /// - Parameters:
    ///   - id: The id to save the Option with in the database.
    ///         Default `nil` value will automatically create an id for the new entry in the database
    ///   - name: The name of the option.
    ///   - priceDifference: The price difference this option adds to a food.
    ///   - optionGroupID: The id of the option group this option is in.
    public init(id: UUID? = nil, name: String, priceDifference: Double, optionGroupID: OptionGroup.IDValue) {
        self.id = id
        self.name = name
        self.priceDifference = priceDifference
        self.$optionGroup.id = optionGroupID
    }
}


