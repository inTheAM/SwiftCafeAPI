//
//  Option+Payload.swift
//  
//
//  Created by Ahmed Mgua on 10/05/2022.
//

import Vapor

public extension Option {
    
    /// The actual data sent when an option is requested by a client.
    struct Payload: Content {
        
        /// The id of the option in the database.
        let id: UUID?
        
        /// The name of the option.
        let name: String
        
        /// The price difference from the base price of the food this option belongs to.
        let priceDifference: PriceDifference
        
        /// The `OptionGroup` this option belongs in.
        let optionGroupID: UUID
    }
    
    func convertToPayload() -> Payload {
        Payload(id: id, name: name, priceDifference: priceDifference, optionGroupID: $optionGroup.id)
    }
}
