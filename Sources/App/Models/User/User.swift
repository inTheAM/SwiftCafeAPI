//
//  User.swift
//  
//
//  Created by Ahmed Mgua on 20/04/2022.
//

import Fluent
import Vapor

/// A user account.
public final class User: Model    {
    
    /// The name of the database table in which the `User`s will be stored.
    ///
    /// Conformance to `FluentKit.Schema`
    public static let schema = "Users"
    
    /// The id of the user in the database.
    ///
    /// Conformance to `FluentKit.Model`.
    @ID(key: .id)
    public var id: UUID?
    
    /// The email address associated with the user's account.
    /// Must be unique.
    @Field(key: Fields.email.key)
    public var email: String
    
    /// The password for the user to sign in to / interact with their account.
    @Field(key: Fields.password.key)
    public var password: String
    
    /// The time the user's account was created.
    /// Filled in automatically on creation.
    @Timestamp(key: Fields.createdOn.key, on: .create)
    public var createdOn: Date?
    
    /// The time the `User` properties were last modified by the user.
    /// Filled in / Updated automatically on modification.
    @Timestamp(key: Fields.lastModifiedOn.key, on: .update)
    public var lastModifiedOn: Date?
    
    /// Conformance to `FluentKit.Model`.
    public init(){}
    
    
    /// Initializes a `User`.
    /// - Parameters:
    ///   - id: The id to save the user with in the database.
    ///         Default `nil` value will automatically create an id for the new entry in the database
    ///   - email: The email address to create the user's account with.
    ///   - password: The user's password.
    public init(id: UUID? = nil, email: String, password: String) {
        self.id = id
        self.email = email
        self.password = password
    }
}


