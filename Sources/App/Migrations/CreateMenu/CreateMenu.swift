//
//  CreateMenu.swift
//  
//
//  Created by Ahmed Mgua on 24/04/2022.
//

import Fluent
import Vapor

/// Creates the menu for our hypothetical restaurant
struct CreateMenu: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        
        // CHICKEN SECTION
        // Creating the section
        let chicken = MenuSection(name: "Chicken", details: "Slowly marinated and flame-grilled to perfection")
        _ = chicken.save(on: database)
        
        // Creating the meals in this section
        let chickenOnly = Food(name: "Chicken", details: "Plain chicken of your chosen size", price: 3.99, sectionID: chicken.id!)
        _ = chickenOnly.save(on: database)
        
        // Adding options to the meal
        chickenOnly.addChickenSizeOptionGroup(on: database)
        chickenOnly.addSpiceOptionGroup(on: database)
        chickenOnly.addSidesOptionGroup(on: database)
        
        let chickenChips = Food(name: "Chicken + Chips", details: "Grilled chicken with a side of chips", price: 5.49, sectionID: chicken.id!)
        _ = chickenChips.save(on: database)
        chickenChips.addSpiceOptionGroup( on: database)
        chickenChips.addChickenSizeOptionGroup(on: database)
        chickenChips.addChipsSizeOptionGroup(on: database)
        chickenChips.addSidesOptionGroup(on: database)
        
        let chickenRice = Food(name: "Chicken + Rice", details: "Grilled chicken with a side of rice", price: 5.99, sectionID: chicken.id!)
        _ = chickenRice.save(on: database)
        
        chickenRice.addSpiceOptionGroup(on: database)
        chickenRice.addChickenSizeOptionGroup(on: database)
        chickenRice.addRiceOptionGroup(on: database)
        chickenRice.addSidesOptionGroup(on: database)
        
        
        // BURGERS SECTION
        let burgers = MenuSection(name: "Burgers", details: "Succulent fillet flame-grilled to perfection")
        _ = burgers.save(on: database)
        let chickenBurger = Food(name: "Chicken Burger", details: "Grilled chicken with toasted sesame bun, lettuce, tomato and caramelized onion", price: 3.49, sectionID: burgers.id!)
            _ = chickenBurger.save(on: database)
        
        chickenBurger.addSpiceOptionGroup(on: database)
        chickenBurger.addSidesOptionGroup(on: database)
        
        
        let burgerChips = Food(name: "Chicken Burger + Chips", details: "Succulent fillet flame-grilled to perfection", price: 5.49, sectionID: burgers.id!)
        _ = burgerChips.save(on: database)
        burgerChips.addSpiceOptionGroup(on: database)
        burgerChips.addChipsSizeOptionGroup(on: database)
        burgerChips.addSidesOptionGroup(on: database)
        
        
        // WRAPS SECTION
        let wrapsPitas = MenuSection(name: "Wraps/Pitas/Pregos", details: "Slowly marinated with explosive flavor and tasty pastry")
        _ = wrapsPitas.save(on: database)
        
        let wrap = Food(name: "Chicken Wrap", details: "Wrap with chicken strips, lettuce, tomato and a dash of our secret sauce", price: 4.49, sectionID: wrapsPitas.id!)
        _ = wrap.save(on: database)
        wrap.addSpiceOptionGroup(on: database)
        wrap.addSidesOptionGroup(on: database)
        
        let pita = Food(name: "Chicken Pita", details: "Pita with chicken strips, lettuce, tomato and a dash of our secret sauce", price: 4.99, sectionID: wrapsPitas.id!)
        _ = pita.save(on: database)
        pita.addSpiceOptionGroup(on: database)
        pita.addSidesOptionGroup(on: database)
        
        let preggo = Food(name: "Chicken Prego", details: "Preggo with chicken strips, lettuce, tomato and a dash of our secret sauce", price: 3.99, sectionID: wrapsPitas.id!)
        _ = preggo.save(on: database)
        preggo.addSpiceOptionGroup(on: database)
        preggo.addSidesOptionGroup(on: database)
        
        
        // CHICKEN STRIPS SECTION
        let chickenStripsSection = MenuSection(name: "Chicken Strips", details: "Juicy chicken strips served with chips/rice")
        _ = chickenStripsSection.save(on: database)
        
        let chickenStripsChips = Food(name: "Chicken Strips + Chips", details: "With massive Galito’s flavour", price: 5.49, sectionID: chickenStripsSection.id!)
        _ = chickenStripsChips.save(on: database)
        
        chickenStripsChips.addSpiceOptionGroup(on: database)
        chickenStripsChips.addChipsSizeOptionGroup(on: database)
        chickenStripsChips.addSidesOptionGroup(on: database)
        
        let chickenStripsRice = Food(name: "Chicken Strips + Rice", details: "With massive Galito’s flavour", price: 5.99, sectionID: chickenStripsSection.id!)
        _ = chickenStripsRice.save(on: database)
        
        chickenStripsRice.addSpiceOptionGroup(on: database)
        chickenStripsRice.addRiceOptionGroup(on: database)
        chickenStripsRice.addSidesOptionGroup(on: database)
        
        let chickenStripsSalad = Food(name: "Chicken Salad", details: "Succulent chicken strips on a bed of tomato, cucumber, assorted peppers, onions and crispy lettuce", price: 5.99, sectionID: chickenStripsSection.id!)
        _ = chickenStripsSalad.save(on: database)
        
        chickenStripsSalad.addSpiceOptionGroup(on: database)
        chickenStripsSalad.addSidesOptionGroup(on: database)
        
        
        // CHICKEN WINGS SECTION
        let chickenWingsSection = MenuSection(name: "Wings", details: "For the love of wings")
        _ = chickenWingsSection.save(on: database)
        
        let wings = Food(name: "Wings only", details: "Bursting with flavor", price: 3.49, sectionID: chickenWingsSection.id!)
        _ = wings.save(on: database)
        
        wings.addSpiceOptionGroup(on: database)
        wings.addWingsOptionGroup(on: database)
        wings.addSidesOptionGroup(on: database)
        
        let wingsChips = Food(name: "Wings + Chips", details: "Bursting with flavor", price: 4.99, sectionID: chickenWingsSection.id!)
        _ = wingsChips.save(on: database)
        
        wingsChips.addSpiceOptionGroup(on: database)
        wingsChips.addWingsOptionGroup(on: database)
        wingsChips.addChipsSizeOptionGroup(on: database)
        wingsChips.addSidesOptionGroup(on: database)
        
        let wingsRice = Food(name: "Wings + Rice", details: "Bursting with flavor", price: 5.49, sectionID: chickenWingsSection.id!)
        _ = wingsRice.save(on: database)
        
        wingsRice.addSpiceOptionGroup(on: database)
        wingsRice.addWingsOptionGroup(on: database)
        wingsRice.addRiceOptionGroup(on: database)
        wingsRice.addSidesOptionGroup(on: database)
        
        // FAMILY MEALS SECTION
        let mealsToShare = MenuSection(name: "Meals to Share", details: "For the whole family")
        _ = mealsToShare.save(on: database)
        
        let mealBox = Food(name: "Galitos Mealbox", details: "Full Chicken and Jumbo Chips", price: 16.99, sectionID: mealsToShare.id!)
        _ = mealBox.save(on: database)
        mealBox.addSpiceOptionGroup(on: database)
        mealBox.addSidesOptionGroup(on: database)
        
        let familyFeast = Food(name: "Family Feast", details: "Full Chicken, Jumbo Chips, Garden Salad and 4 Rolls", price: 18.99, sectionID: mealsToShare.id!)
        _ = familyFeast.save(on: database)
        familyFeast.addSpiceOptionGroup(on: database)
        familyFeast.addSidesOptionGroup(on: database)
        
        
        
        
        
        // CHIPS SECTION
        let chips = MenuSection(name: "Chips", details: "Crispy potato goodness")
        _ = chips.save(on: database)
        _ = Food(name: "Regular", details: "Regular size chips", price: 1.49, sectionID: chips.id!).save(on: database)
        _ = Food(name: "Large", details: "Medium size chips", price: 2.49, sectionID: chips.id!).save(on: database)
        _ = Food(name: "Jumbo", details: "Jumbo size chips", price: 2.99, sectionID: chips.id!).save(on: database)
        
        // RICE SECTION
        let rice = MenuSection(name: "Rice", details: "Made just for you")
        _ = rice.save(on: database)
        _ = Food(name: "Plain Rice", details: "", price: 1.99, sectionID: rice.id!).save(on: database)
        _ = Food(name: "Spicy Rice", details: "", price: 2.49, sectionID: rice.id!).save(on: database)
        
        // SIDES SECTION
        let sides = MenuSection(name: "Sides", details: "More flavor")
        _ = sides.save(on: database)
        _ = Food(name: "Peri-peri Mayo", details: "", price: 0.99, sectionID: sides.id!).save(on: database)
        _ = Food(name: "Coleslaw", details: "", price: 0.99, sectionID: sides.id!).save(on: database)
        
        
        // DRINKS SECTION
        let drinks = MenuSection(name: "Drinks", details: "Stay hydrated")
        _ = drinks.save(on: database)
        _ = Food(name: "Water", details: "", price: 0.99, sectionID: drinks.id!).save(on: database)
        _ = Food(name: "Pet 500ml", details: "", price: 0.99, sectionID: drinks.id!).save(on: database)
        return Food(name: "Soft Drink 2L", details: "", price: 2.49, sectionID: drinks.id!).save(on: database)
        
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        
        // Removing the sections from the database
        _ = MenuSection.query(on: database)
            .filter(\.$name == "Chicken")
            .delete()
        
        _ = MenuSection.query(on: database)
            .filter(\.$name == "Burgers")
            .delete()
        
        _ = MenuSection.query(on: database)
            .filter(\.$name == "Wraps/Pitas/Pregos")
            .delete()
        
        _ = MenuSection.query(on: database)
            .filter(\.$name == "Chicken Strips")
            .delete()
        
        _ = MenuSection.query(on: database)
            .filter(\.$name == "Wings")
            .delete()
        
        _ = MenuSection.query(on: database)
            .filter(\.$name == "Meals to Share")
            .delete()
        
        _ = MenuSection.query(on: database)
            .filter(\.$name == "Chips")
            .delete()
        
        _ = MenuSection.query(on: database)
            .filter(\.$name == "Rice")
            .delete()
        
        _ = MenuSection.query(on: database)
            .filter(\.$name == "Sides")
            .delete()
        
        return MenuSection.query(on: database)
            .filter(\.$name == "Drinks")
            .delete()
        
    }
}
