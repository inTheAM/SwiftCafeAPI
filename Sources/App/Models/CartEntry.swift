//
//  CartEntry.swift
//  
//
//  Created by Ahmed Mgua on 20/04/2022.
//

import Fluent
import Vapor

final class CartEntry: Model    {
    static let schema = "CartEntries"
    
    @ID
    var id: UUID?
    
    @Field(key: "Quantity")
    var quantity: Int
    
    @Parent(key: "CartID")
    var cart: Cart
    
    @Parent(key: "FoodID")
    var food: Food
    
    @Timestamp(key: "CreatedOn", on: .create)
    var createdOn: Date?
    
    @Timestamp(key: "LastModifiedOn", on: .update)
    var lastModifiedOn: Date?
    
    init() {}
    
    init(id: UUID? = nil, quantity: Int, cart: Cart, food: Food) throws {
        self.id = id
        self.quantity = quantity
        self.$cart.id = try cart.requireID()
        self.$food.id = try food.requireID()
    }
}

extension CartEntry {
    struct Payload: Content {
        var id: UUID?
        var food: Food.Payload
        var quantity: Int
    }
    
    func convertToPayload(food: Food.Payload) -> Payload {
        return Payload(id: id, food: food, quantity: quantity)
    }
}

extension CartEntry {
    struct CreateData: Content {
        var merchandiseID: UUID
        var quantity: Int
    }
    
    struct RemoveData: Content {
        var id: UUID
    }
}
