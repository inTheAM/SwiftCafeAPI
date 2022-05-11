//
//  CartEntry.swift
//  
//
//  Created by Ahmed Mgua on 20/04/2022.
//

import Fluent
import Vapor

/// An entry in the user's cart.
/// Contains the `Food` item, the quantity, and the `Option`s selected.
public final class CartEntry: Model    {
    
    public typealias Quantity = Int
    
    /// The name of the database table in which `CartEntry` values will be stored.
    ///
    /// Conformance to `FluentKit.Schema`
    public static let schema = "CartEntries"
    
    /// The id of the entry in the database.
    ///
    /// Conformance to `FluentKit.Model`.
    @ID
    public var id: UUID?
    
    /// The quantity of the `Food` item added.
    @Field(key: Fields.quantity.key)
    public var quantity: Quantity
    
    /// The `Cart` this entry is in.
    ///
    /// Created as a one-one relationship between the `"CartEntries"` table and the `"Carts"` table in
    /// the database since a cart entry can only be in one cart.
    @Parent(key: Fields.cartID.key)
    public var cart: Cart
    
    /// The `Food` item referenced in this entry.
    ///
    /// Created as a one-one relationship between the `"CartEntries"` table and the `"Food"` table in
    /// the database since a cart entry can only contain one food item.
    @Parent(key: Fields.foodID.key)
    public var food: Food
    
    /// The `Option`s selected by the user for the `Food`.
    ///
    /// Created as a many - many relationship between the `"CartEntries"` table and the `"Options"` table in the
    /// database since multiple cart entries may have  the same options selected.
    /// `OptionEntry` is used here as the pivot that connects the two tables.
    @Siblings(through: OptionEntry.self, from: \.$cartEntry, to: \.$option)
    public var options: [Option]
    
    /// The time the cart entry was added to the user's cart.
    /// Filled automatically on creation.
    @Timestamp(key: Fields.createdOn.key, on: .create)
    public var createdOn: Date?
    
    /// The time the entry was last modified by the user.
    /// Updated automatically on modification.
    @Timestamp(key: Fields.lastModifiedOn.key, on: .update)
    public var lastModifiedOn: Date?
    
    /// Conformance to `FluentKit.Model`.
    public init() {}
    
    
    /// Creates a `CartEntry`.
    /// - Parameters:
    ///   - id: The id to save the cart entry with in the database.
    ///         Default `nil` value will automatically create an id for the new entry in the database.
    ///   - quantity: The quantity of the selected food in the cart entry.
    ///   - cart: The cart to which this entry is linked.
    ///   - food: The food item to which this entry is linked.
    public init(id: UUID? = nil, quantity: Int, cart: Cart, food: Food) throws {
        self.id = id
        self.quantity = quantity
        self.$cart.id = try cart.requireID()
        self.$food.id = try food.requireID()
    }
}
