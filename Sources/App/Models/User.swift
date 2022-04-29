//
//  User.swift
//  
//
//  Created by Ahmed Mgua on 20/04/2022.
//

import Fluent
import Vapor

final class User: Model    {
    static let schema = "Users"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "Email")
    var email: String
    
    @Field(key: "Password")
    var password: String
    
    @OptionalChild(for: \.$user)
    var cart: Cart?
    
    @Timestamp(key: "CreatedOn", on: .create)
    var createdOn: Date?
    
    @Timestamp(key: "LastModifiedOn", on: .update)
    var lastModifiedOn: Date?
    
    init(){}
    
    init(id: UUID? = nil, email: String, password: String) {
        self.id = id
        self.email = email
        self.password = password
    }
}

extension User {
    struct Payload: Content {
        var id: UUID?
        var email: String
    }
    
    func convertToResult() -> Payload.APIResult {
        return Payload(id: id, email: email).convertToResult()
    }
}

extension User {
    struct CreateData: Content {
        let email: String
        let password: String
    }
    struct ValidateData: Content {
        let email: String
    }
    struct EmailCheckResult: Content {
        let isAvailable: Bool
    }
    enum AuthResult: Content {
        case success, failure
    }
}

extension User: ModelAuthenticatable {
    static let usernameKey = \User.$email
    static let passwordHashKey = \User.$password
    
    func verify(password: String) throws -> Bool {
        try Bcrypt.verify(password, created: self.password)
    }
}
