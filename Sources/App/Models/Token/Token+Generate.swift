//
//  Token+Generate.swift
//  
//
//  Created by Ahmed Mgua on 10/05/2022.
//

import Foundation

public extension Token {
    
    /// Generates a 16-character, base64 encoded, `String` token for the user.
    /// - Parameter user: The user to create a token for.
    /// - Returns: A `Token` for the user.
    static func generate(for user: User) throws -> Token {
        let value = [UInt8].random(count: 16).base64
        let token = try Token(value: value, userID: user.requireID())
        return token
    }
}
