//
//  Token.swift
//  
//
//  Created by Ahmed Mgua on 20/04/2022.
//

import Fluent
import Vapor

final class Token: Model {
    static var schema = "Tokens"
    
    @ID
    var id: UUID?
    
    @Field(key: "Value")
    var value: String
    
    @Parent(key: "UserID")
    var user: User
    
    @Timestamp(key: "CreatedOn", on: .create)
    var createdOn: Date?
    
    @Timestamp(key: "LastModifiedOn", on: .update)
    var lastModifiedOn: Date?
    
    init() {}
    
    init(id: UUID? = nil, value: String, userID: User.IDValue) {
        self.id = id
        self.value = value
        self.$user.id = userID
    }
}

extension Token {
    struct Payload: Content {
        let value: String
    }
    
    func convertToResult() -> Payload.APIResult {
        Payload(value: value).convertToResult()
    }
}

extension Token {
    static func generate(for user: User) throws -> Token {
        let value = [UInt8].random(count: 16).base64
        let token = try Token(value: value, userID: user.requireID())
        return token
    }
}

extension Token: ModelTokenAuthenticatable {
    static let valueKey = \Token.$value
    static let userKey = \Token.$user
    
    var isValid: Bool {
        true
    }
}

