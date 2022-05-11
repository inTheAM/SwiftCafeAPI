//
//  Token+Payload.swift
//  
//
//  Created by Ahmed Mgua on 10/05/2022.
//

import Vapor

public extension Token {
    
    /// The actual data sent when the `Token` is requested by a client.
    struct Payload: Content {
        
        /// The value of the token.
        let value: String
    }
    
    /// Converts a `Token` model into a `Payload` that can be sent to clients.
    /// - Returns: The `Payload` form of the `Token`.
    func convertToPayload() -> Payload {
        Payload(value: value)
    }
}
