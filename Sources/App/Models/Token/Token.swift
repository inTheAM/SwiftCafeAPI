//
//  Token.swift
//  
//
//  Created by Ahmed Mgua on 20/04/2022.
//

import Fluent
import Vapor

public final class Token: Model {
    
    /// The name of the database table in which `Token`s will be stored.
    ///
    /// Conformance to `FluentKit.Schema`
    public static var schema = "Tokens"
    
    /// The id of the token in the database.
    ///
    /// Conformance to `FluentKit.Model`.
    @ID
    public var id: UUID?
    
    /// The value of the token.
    @Field(key: Fields.value.key)
    public var value: String
    
    /// The user this token is associated with.
    ///
    /// Created as a one-one relationship between the `"Users"` table and the `"Tokens"` table in
    /// the database since each token can only belong to one user.
    @Parent(key: Fields.userID.key)
    public var user: User
    
    /// The time the token was created for the user.
    /// Filled automatically on creation.
    @Timestamp(key: Fields.createdOn.key, on: .create)
    public var createdOn: Date?
    
    /// The time the token was last modified.
    /// Updated automatically on modification..
    @Timestamp(key: Fields.lastModifiedOn.key, on: .update)
    public var lastModifiedOn: Date?
    
    /// Conformance to `FluentKit.Model`.
    public init() {}
    
    /// Initializes a `Token` model.
    /// - Parameters:
    ///   - id: The id the token will be saved with in the database.
    ///         Default `nil` value will automatically create an id for the new entry in the database
    ///   - value: The value of the token.
    ///   - userID: The id of the user the token is associated with.
    public init(id: UUID? = nil, value: String, userID: User.IDValue) {
        self.id = id
        self.value = value
        self.$user.id = userID
    }
}



