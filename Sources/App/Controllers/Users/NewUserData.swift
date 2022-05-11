//
//  User+NewUserData.swift
//  
//
//  Created by Ahmed Mgua on 10/05/2022.
//

import Vapor

public extension UsersController {
    /// The data used to create a new user.
    struct NewUserData: Content {
        
        /// The email address to create the user's account with.
        let email: String
        
        /// The password to authenticate the user with in future sign-ins.
        let password: String
    }
}
