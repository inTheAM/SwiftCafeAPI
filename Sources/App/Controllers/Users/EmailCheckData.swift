//
//  EmailCheckData.swift
//  
//
//  Created by Ahmed Mgua on 10/05/2022.
//

import Vapor

public extension UsersController {
    /// The data sent in a request by a client to check if an email address is available.
    struct EmailCheckData: Content {
        
        /// The email address to check for in the database.
        let email: String
    }
}
