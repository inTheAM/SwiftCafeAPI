//
//  RemoveFromCartData.swift
//  
//
//  Created by Ahmed Mgua on 10/05/2022.
//

import Vapor


public extension CartsController {
    
    /// The data sent by a client to delete a selected
    /// cart entry from a user's cart.
    struct RemoveFromCartData: Content {
        
        /// The id of the cart entry to delete
        let id: UUID
    }
}
