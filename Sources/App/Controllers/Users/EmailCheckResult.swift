//
//  File.swift
//  
//
//  Created by Ahmed Mgua on 11/05/2022.
//

import Vapor

public extension UsersController {
    
    /// The data sent in a response to a client to confirm if an email address is available.
    struct EmailCheckResult: Content {
        
        /// Whether the email address is available or not.
        let isAvailable: Bool
    }
}
