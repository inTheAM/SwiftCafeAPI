//
//  Food.swift
//  
//
//  Created by Ahmed Mgua on 20/04/2022.
//

import Fluent
import Vapor

final class Food: Model    {
    static var schema: String = "Food"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "Name")
    var name: String
    
    @Field(key: "Details")
    var details: String
    
    @Field(key: "Price")
    var price: Double
    
    @Field(key: "ImageURL")
    var imageURL: String
    
    @Parent(key: "MenuSection")
    var section: MenuSection
    
    @Children(for: \.$food)
    var optionGroups: [OptionGroup]
    
    @Timestamp(key: "CreatedOn", on: .create)
    var createdOn: Date?
    
    @Timestamp(key: "LastModifiedOn", on: .update)
    var lastModifiedOn: Date?
    
    init() {}
    
    init(id: UUID? = nil, name: String, details: String, price: Double, sectionID: MenuSection.IDValue)    {
        self.id = id
        self.name = name
        self.details = details
        #warning("FIX IMAGES")
        self.imageURL = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTP68GaMxj6iSn18pYEVZyW0lLLYgbEzbdmFQ&usqp=CAU"
        self.price = price
        self.$section.id = sectionID
    }
}

extension Food {
    struct Payload: Content {
        var id: UUID?
        var name: String
        var details: String
        var optionGroups: [OptionGroup]
        var price: Double
        var sectionID: UUID
        var imageURL: String
    }
    
    func convertToPayload() -> Payload {
        return Payload(id: id, name: name, details: details, optionGroups: [], price: price, sectionID: $section.id, imageURL: imageURL)
    }
}

