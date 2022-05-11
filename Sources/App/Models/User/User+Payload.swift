//
//  User+Payload.swift
//  
//
//  Created by Ahmed Mgua on 10/05/2022.
//

import Vapor

public extension User {
    
    /// The actual user data sent when requested by a client.
    struct Payload: Content {
        
        /// The id of the user in the database.
        let id: UUID?
        
        /// The email address of the user.
        let email: String
    }
    
    /// Converts a `User` model to a `Payload`.
    /// - Returns: The `Payload` form of the user data.
    func convertToPayload() -> Payload {
        return Payload(id: id, email: email)
    }
}
