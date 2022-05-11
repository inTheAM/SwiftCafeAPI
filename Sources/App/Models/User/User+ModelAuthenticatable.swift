//
//  User+ModelAuthenticatable.swift
//  
//
//  Created by Ahmed Mgua on 10/05/2022.
//

import Fluent
import Vapor

/// Extends the `User` model to be used to authenticate / authorize requests.
extension User: ModelAuthenticatable {
    
    /// The KeyPath to the user's email address.
    public static let usernameKey = \User.$email
    
    /// The KeyPath to the user's hashed password.
    public static let passwordHashKey = \User.$password
    
    
    /// Conformance to `Fluent`'s `ModelAuthenticatable`.
    /// Checks a given password against the user's stored, hashed password to authenticate the user.
    /// - Parameter password: The password to check against the stored hash.
    /// - Returns: A Boolean. `true` if the password was a match and `false` if not.
    public func verify(password: String) throws -> Bool {
        try Bcrypt.verify(password, created: self.password)
    }
}
