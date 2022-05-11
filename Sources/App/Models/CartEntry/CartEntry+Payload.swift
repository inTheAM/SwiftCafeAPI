//
//  CartEntry+Payload.swift
//  
//
//  Created by Ahmed Mgua on 09/05/2022.
//

import Vapor

public extension CartEntry {
    
    /// The data that is actually sent when the cart entry is requested by a client.
    struct Payload: Content {
        
        /// The id of the cart entry in the database.
        let id: UUID?
        
        /// The `Food` item referenced in the cart entry.
        let food: Food.Payload
        
        /// The quantity of the food item selected.
        let quantity: Quantity
        
        /// The selected options in this entry.
        /// Sent as an array of `Payload` forms of an `Option`
        let options: [Option.Payload]
    }
    
    /// Converts a `CartEntry` model into its `Payload` form.
    /// - Parameters:
    ///   - food: The `Food` item selected in this entry.
    ///   - options: The `Option`s selected in this entry.
    /// - Returns: A `Payload` form of a `CartEntry` containing only the relevant properties.
    func convertToPayload(food: Food.Payload, options: [Option.Payload]) -> Payload {
        return Payload(id: id, food: food, quantity: quantity, options: options)
    }
}
