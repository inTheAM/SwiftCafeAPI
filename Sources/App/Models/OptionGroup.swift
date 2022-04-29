//
//  OptionGroup.swift
//  
//
//  Created by Ahmed Mgua on 20/04/2022.
//

import Fluent
import Vapor

final class OptionGroup: Model {
    static let schema: String = "OptionGroups"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "Name")
    var name: String
    
    @Parent(key: "FoodID")
    var food: Food
    
    @Children(for: \.$optionGroup)
    var options: [Option]
    
    @Timestamp(key: "CreatedOn", on: .create)
    var createdOn: Date?
    
    @Timestamp(key: "LastModifiedOn", on: .update)
    var lastModifiedOn: Date?
    
    init() {}
    
    init(id: UUID? = nil, name: String, foodID: Food.IDValue) {
        self.id = id
        self.name = name
        self.$food.id = foodID
    }
}

extension OptionGroup {
    struct Payload: Content {
        let id: UUID?
        let name: String
        var options: [Option.Payload]
    }
    func convertToPayload(options: [Option.Payload]) -> Payload {
        Payload(id: id, name: name, options: options)
    }
}


final class Option: Model {
    
    static let schema: String = "Options"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "Name")
    var name: String
    
    @Field(key: "PriceDifference")
    var priceDifference: Double
    
    @Parent(key: "OptionGroup")
    var optionGroup: OptionGroup
    
    @Timestamp(key: "CreatedOn", on: .create)
    var createdOn: Date?
    
    @Timestamp(key: "LastModifiedOn", on: .update)
    var lastModifiedOn: Date?
    
    init() {}
    
    init(id: UUID? = nil, name: String, priceDifference: Double, optionGroupID: OptionGroup.IDValue) {
        self.id = id
        self.name = name
        self.priceDifference = priceDifference
        self.$optionGroup.id = optionGroupID
    }
}

extension Option {
    struct Payload: Content {
        let id: UUID?
        let name: String
        let priceDifference: Double
    }
    
    func convertToPayload() -> Payload {
        Payload(id: id, name: name, priceDifference: priceDifference)
    }
}
