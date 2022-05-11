//
//  CreateDummyUser.swift
//  
//
//  Created by Ahmed Mgua on 08/05/2022.
//

import Fluent
import Vapor

/// Creates/Removes a test user in the database. 
public struct CreateDummyUser: Migration {
    private let dummyUser = User(email: "testuser@gmail.com", password: "testuseroxx123!")
    
    public func prepare(on database: Database) -> EventLoopFuture<Void> {
        let password = try! Bcrypt.hash(dummyUser.password)
        let user = User(email: dummyUser.email, password: password)
        _ = user.save(on: database)
        
        let cart = Cart(userID: user.id!)
        return cart.save(on: database)
    }
    
    public func revert(on database: Database) -> EventLoopFuture<Void> {
        return User.query(on: database)
            .filter(\.$email == dummyUser.email)
            .delete()
    }
}
