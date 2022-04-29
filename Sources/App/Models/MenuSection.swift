//
//  File.swift
//  
//
//  Created by Ahmed Mgua on 20/04/2022.
//

import Fluent
import Vapor

final class MenuSection: Model    {
    static var schema = "MenuSections"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "Name")
    var name: String
    
    @Field(key: "Details")
    var details: String
    
    @Children(for: \.$section)
    var items: [Food]
    
    @Timestamp(key: "CreatedOn", on: .create)
    var createdOn: Date?
    
    @Timestamp(key: "LastModifiedOn", on: .update)
    var lastModifiedOn: Date?
    
    init(){}
    
    init(id: UUID? = nil, name: String, details: String)    {
        self.id = id
        self.name = name
        self.details = details
    }
}

extension MenuSection {
    struct Payload: Content {
        var id:    UUID?
        var name:    String
        var items: [Food.Payload]
    }
    
    func convertToPayload(items: [Food.Payload] = []) -> Payload {
        return Payload(id: id, name: name, items: items)
    }
}

