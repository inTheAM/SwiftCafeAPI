//
//  Cart+Payload.swift
//  
//
//  Created by Ahmed Mgua on 09/05/2022.
//

import Vapor

public extension Cart {
    
    /// The data that is actually sent when the cart is requested by a client.
    struct Payload: Content {
        
        /// The id of the cart in the database.
        let id: Cart.IDValue?
        
        /// The id of the user the cart belongs to.
        let userID: User.IDValue
        
        /// The contents of the cart.
        ///
        /// Sent as an array of `Payload` forms of a `CartEntry`.
        let contents: [CartEntry.Payload]
    }
    
    /// Converts a `Cart` model to a `Payload`.
    /// - Parameter contents: The cart entries to be placed in the cart.
    /// - Returns: The `Payload` form of the user's cart.
    func convertToPayload(contents: [CartEntry.Payload]) -> Payload {
        return Payload(id: id, userID: $user.id, contents: contents)
    }
}
