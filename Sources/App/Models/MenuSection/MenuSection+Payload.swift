//
//  MenuSection+Payload.swift
//  
//
//  Created by Ahmed Mgua on 10/05/2022.
//

import Vapor

public extension MenuSection {
    
    /// The data that is actually sent when the section is requested by a client.
    struct Payload: Content {
        
        /// The id of the section in the database.
        let id:    MenuSection.IDValue?
        
        /// The name of the section.
        let name:    String
        
        /// The description of the section.
        let details: String
        
        /// The `Food` items in the section.
        let items: [Food.Payload]
    }
    
    /// Converts a `MenuSection` model to a `Payload`.
    /// - Parameter items: The `Payload` forms of the  `Food` items in the menu section.
    /// - Returns: The `Payload` form of the menu section.
    func convertToPayload(items: [Food.Payload]) -> Payload {
        return Payload(id: id, name: name, details: details, items: items)
    }
}
