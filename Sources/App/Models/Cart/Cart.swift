//
//  Cart.swift
//  
//
//  Created by Ahmed Mgua on 20/04/2022.
//

import Fluent
import Vapor
import CloudKit

/// The user's cart.
public final class Cart: Model    {
    
    /// The name of the database table in which the `Cart`s will be stored.
    ///
    /// Conformance to `FluentKit.Schema`
    public static let schema = "Carts"
    
    /// The id of the cart in the database.
    ///
    /// Conformance to `FluentKit.Model`.
    @ID(key: .id)
    public var id: UUID?
    
    /// The user to whom this cart belongs.
    ///
    /// Created as a one-one relationship between the `"Users"` table and the `"Carts"` table in
    /// the database since each cart can only belong to one user.
    @Parent(key: Fields.userID.key)
    public var user: User
    
    /// The contents of the cart.
    ///
    /// Created as a many to many relationship between the `"Carts"` table and the `"Food"` table in
    /// the database since multiple users may have  the same item in their carts.
    /// `CartEntry` is used here as the pivot that connects the two tables.
    @Siblings(through: CartEntry.self, from: \.$cart, to: \.$food)
    public var contents: [Food]
    
    /// The time the cart was created for the user.
    /// Filled automatically on creation.
    @Timestamp(key: Fields.createdOn.key, on: .create)
    public var createdOn: Date?
    
    /// The time the cart was last modified by the user.
    /// Updated automatically on modification.
    @Timestamp(key: Fields.lastModifiedOn.key, on: .update)
    public var lastModifiedOn: Date?
    
    /// Conformance to `FluentKit.Model`.
    public init(){}
    
    
    /// Creates a `Cart` for a user.
    /// - Parameters:
    ///   - id: The id to save the cart in the database with.
    ///         Default `nil` value will automatically create an id for the new entry in the database.
    ///   - userID: The id of the user this cart will be linked to
    public init(id: UUID? = nil, userID: User.IDValue)    {
        self.id = id
        self.$user.id = userID
    }
}


