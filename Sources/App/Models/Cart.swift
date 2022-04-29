//
//  Cart.swift
//  
//
//  Created by Ahmed Mgua on 20/04/2022.
//

import Fluent
import Vapor

final class Cart: Model    {
    static let schema = "Carts"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "UserID")
    var user: User
    
    @Siblings(through: CartEntry.self, from: \.$cart, to: \.$food)
    var contents: [Food]
    
    @Timestamp(key: "CreatedOn", on: .create)
    var createdOn: Date?
    
    @Timestamp(key: "LastModifiedOn", on: .update)
    var lastModifiedOn: Date?
    
    init(){}
    
    init(id: UUID? = nil, userID: User.IDValue)    {
        self.id = id
        self.$user.id = userID
    }
}

extension Cart {
    struct Payload: Content {
        var id: UUID?
        var userID: UUID
        var contents: [CartEntry.Payload]
    }
    
    func convertToPayload(contents: [CartEntry.Payload] = []) -> Payload {
        return Payload(id: id, userID: $user.id, contents: contents)
    }
}

extension Cart: Equatable {
    static func == (lhs: Cart, rhs: Cart) -> Bool {
        lhs.id == rhs.id
    }
}
