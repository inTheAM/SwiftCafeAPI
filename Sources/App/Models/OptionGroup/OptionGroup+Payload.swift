//
//  File.swift
//  
//
//  Created by Ahmed Mgua on 10/05/2022.
//

import Vapor

public extension OptionGroup {
    
    /// The data that is actually sent when the food is requested by a client.
    struct Payload: Content {
        
        /// The id of the option group.
        let id: UUID?
        
        /// The name of the option group.
        let name: String
        
        /// The options in the option group.
        let options: [Option.Payload]
    }
    
    /// Converts an `OptionGroup` model to a `Payload`.
    /// - Parameter options: An array of the `Payload` forms of the options in the option group.
    /// - Returns: The `Payload` form of an option group.
    func convertToPayload(options: [Option.Payload]) -> Payload {
        Payload(id: id, name: name, options: options)
    }
}
