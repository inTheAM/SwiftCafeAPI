//
//  AddToCartData.swift
//  
//
//  Created by Ahmed Mgua on 10/05/2022.
//

import Vapor

public extension CartsController {
    
    typealias Quantity = Int
    /// The data sent by a client to add a cart entry to a user's cart.
    struct AddToCartData: Content {
        
        /// The id of the food item selected.
        let foodID: Food.IDValue
        
        /// The quantity the user selected.
        let quantity: Quantity
        
        /// The options selected by the user
        let options: [Option.IDValue]
    }
}
