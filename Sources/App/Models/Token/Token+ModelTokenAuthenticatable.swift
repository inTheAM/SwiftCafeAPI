//
//  Token+ModelTokenAuthenticatable.swift
//  
//
//  Created by Ahmed Mgua on 10/05/2022.
//

import Fluent

/// Extends `Token` to be used to authorize requests.
extension Token: ModelTokenAuthenticatable {
    
    /// The KeyPath to the value of the token.
    public static let valueKey = \Token.$value
    
    /// The KeyPath to the user the token is associated with.
    public static let userKey = \Token.$user
    
    /// Checks whether the token for the user is currently valid.
    ///
    /// Can be adjusted to include time validation.
    public var isValid: Bool {
        true
    }
}
