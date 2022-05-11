//
//  Food.swift
//  
//
//  Created by Ahmed Mgua on 20/04/2022.
//

import Fluent
import Vapor

/// A Food item.
public final class Food: Model    {
    
    public typealias DollarPrice = Double
    
    /// The name of the database table in which the `Food` values will be stored.
    ///
    /// Conformance to `FluentKit.Schema`
    public static var schema: String = "Food"
    
    /// The id of the food in the database.
    ///
    /// Conformance to `FluentKit.Model`.
    @ID(key: .id)
    public var id: UUID?
    
    /// The name of the food.
    @Field(key: Fields.name.key)
    public var name: String
    
    /// The description of the food.
    @Field(key: Fields.details.key)
    public var details: String
    
    /// The price of the food.
    @Field(key: Fields.price.key)
    public var price: DollarPrice
    
    /// The url of the image that shows the food.
    @Field(key: Fields.imageURL.key)
    public var imageURL: String
    
    /// The section of the menu to which this food belongs.
    ///
    /// Created as a one-many relationship between the `"MenuSection"` table and the `"Food"` table in
    /// the database since each food can only be in one section but each section can have multiple food entries..
    @Parent(key: Fields.sectionID.key)
    public var section: MenuSection
    
    /// The option groups available for this food.
    ///
    /// Created as a one-many relationship between the `"Food"` table and the `"OptionGroups"` table in
    /// the database since each food can have multiple option groups.
    @Children(for: \.$food)
    public var optionGroups: [OptionGroup]
    
    /// The time the food was added to the database.
    /// Filled in automatically on creation.
    @Timestamp(key: Fields.createdOn.key, on: .create)
    public var createdOn: Date?
    
    /// The time the food properties were last modified.
    /// Filled in / Updated automatically on modification.
    @Timestamp(key: Fields.lastModifiedOn.key, on: .update)
    public var lastModifiedOn: Date?
    
    /// Conformance to `FluentKit.Model`.
    public init() {}
    
    
    /// <#Description#>
    /// - Parameters:
    ///   - id: <#id description#>
    ///   - name: <#name description#>
    ///   - details: <#details description#>
    ///   - price: <#price description#>
    ///   - sectionID: <#sectionID description#>
    public init(id: UUID? = nil, name: String, details: String, price: DollarPrice, sectionID: MenuSection.IDValue)    {
        self.id = id
        self.name = name
        self.details = details
        
        #warning("Add different image for each food")
        self.imageURL = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTP68GaMxj6iSn18pYEVZyW0lLLYgbEzbdmFQ&usqp=CAU"
        self.price = price
        self.$section.id = sectionID
    }
}
