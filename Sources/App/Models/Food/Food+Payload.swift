//
//  File.swift
//  
//
//  Created by Ahmed Mgua on 10/05/2022.
//

import Vapor

public extension Food {
    
    /// The data that is actually sent when the food is requested by a client.
    struct Payload: Content {
        
        /// The id of the food in the database.
        let id: UUID?
        
        /// The name of the food.
        let name: String
        
        /// The description of the food.
        let details: String
        
        /// The price of the food.
        let price: DollarPrice
        
        /// The url of the image that shows the food.
        let imageURL: String
        
        /// The id of the section of the menu to which this food belongs.
        let sectionID: MenuSection.IDValue
    }
    
    /// Converts a `Food` model to a `Payload`.
    /// - Returns: The `Payload` form of the `Food`.
    func convertToPayload() -> Payload {
        return Payload(id: id, name: name, details: details, price: price, imageURL: imageURL, sectionID: $section.id)
    }
}

