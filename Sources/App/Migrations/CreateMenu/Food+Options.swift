//
//  Food+Options.swift
//  
//
//  Created by Ahmed Mgua on 06/05/2022.
//

import Fluent
import Vapor

/// Adds options to the `Food`s.
extension Food {
    
    
    /// Adds chicken size options to a chicken dish.
    func addChickenSizeOptionGroup(on database: Database) {
        let chickenSizeOptionGroup = OptionGroup(name: "Chicken size", foodID: self.id!)
        _ = chickenSizeOptionGroup.save(on: database)
        
        _ = Option(name: "Quarter", priceDifference: 0, optionGroupID: chickenSizeOptionGroup.id!).save(on: database)
        
        _ = Option(name: "Half", priceDifference: 3, optionGroupID: chickenSizeOptionGroup.id!).save(on: database)
        
        _ = Option(name: "Full", priceDifference: 6, optionGroupID: chickenSizeOptionGroup.id!).save(on: database)
    }
    
    /// Adds portion sizes to chicken wing dishes.
    func addWingsOptionGroup(on database: Database) {
        let wingsOptionGroup = OptionGroup(name: "Serving size", foodID: self.id!)
        _ = wingsOptionGroup.save(on: database)
        
        _ = Option(name: "Five winglets", priceDifference: 0, optionGroupID: wingsOptionGroup.id!).save(on: database)
        
        _ = Option(name: "Ten winglets", priceDifference: 3.49, optionGroupID: wingsOptionGroup.id!).save(on: database)
    }
    
    /// Adds chips/fries size options to 
    func addChipsSizeOptionGroup(on database: Database) {
        let chipsSizeOptionGroup = OptionGroup(name: "Chips size", foodID: self.id!)
        _ = chipsSizeOptionGroup.save(on: database)
        
        _ = Option(name: "Regular", priceDifference: 0, optionGroupID: chipsSizeOptionGroup.id!).save(on: database)
        
        _ = Option(name: "Large", priceDifference: 1, optionGroupID: chipsSizeOptionGroup.id!).save(on: database)
        
        _ = Option(name: "Jumbo", priceDifference: 1.5, optionGroupID: chipsSizeOptionGroup.id!).save(on: database)
    }
    
    func addRiceOptionGroup(on database: Database) {
        let riceOptionGroup = OptionGroup(name: "Chips size", foodID: self.id!)
        _ = riceOptionGroup.save(on: database)
        
        _ = Option(name: "Regular", priceDifference: 0, optionGroupID: riceOptionGroup.id!).save(on: database)
        
        _ = Option(name: "Spicy", priceDifference: 0.49, optionGroupID: riceOptionGroup.id!).save(on: database)
    }
    
    func addSpiceOptionGroup(on database: Database) {
        let spiceOptionGroup = OptionGroup(name: "Spiciness", foodID: self.id!)
        _ = spiceOptionGroup.save(on: database)
        
        _ = Option(name: "Plain - no spice", priceDifference: 0, optionGroupID: spiceOptionGroup.id!).save(on: database)
        
        _ = Option(name: "Spicy - mild", priceDifference: 0, optionGroupID: spiceOptionGroup.id!).save(on: database)
        
        _ = Option(name: "Spicy - HOT", priceDifference: 0, optionGroupID: spiceOptionGroup.id!).save(on: database)
    }
    
    func addSidesOptionGroup(on database: Database) {
        let sidesOptionGroup = OptionGroup(name: "Sides", foodID: self.id!)
        _ = sidesOptionGroup.save(on: database)
        
        _ = Option(name: "Coleslaw", priceDifference: 1, optionGroupID: sidesOptionGroup.id!).save(on: database)
        
        _ = Option(name: "Garden salad", priceDifference: 2, optionGroupID: sidesOptionGroup.id!).save(on: database)
        
        _ = Option(name: "Periperi mayo", priceDifference: 1, optionGroupID: sidesOptionGroup.id!).save(on: database)
    }
}
