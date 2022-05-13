//
//  File.swift
//  
//
//  Created by Ahmed Mgua on 10/05/2022.
//

import Fluent
import Vapor


/// A selection of an option when adding a `Food` to the cart as a `CartEntry`
public final class OptionEntry: Model {
    
    /// The name of the database table in which `OptionEntry` values will be stored.
    ///
    /// Conformance to `FluentKit.Schema`
    public static var schema: String = "OptionEntries"
    
    /// The id of the option entry in the database.
    ///
    /// Conformance to `FluentKit.Model`.
    @ID(key: .id)
    public var id: UUID?
    
    /// The `Option` this option entry is linked to.
    ///
    /// Created as a one-one relationship between the `"Options"` table and the `"OptionEntries"` table in
    /// the database since each entry can only link one option.
    @Parent(key: Fields.optionID.key)
    public var option: Option
    
    /// The `CartEntry` this option entry is linked to.
    ///
    /// Created as a one-one relationship between the `"Options"` table and the `"CartEntries"` table in the database since each entry can only link one cart entry.
    @Parent(key: Fields.cartEntryID.key)
    public var cartEntry: CartEntry
    
    /// Conformance to `FluentKit.Model`.
    public init(){}
    
    init(option: Option, cartEntry: CartEntry) throws {
        self.$cartEntry.id = try cartEntry.requireID()
        self.$option.id = try option.requireID()
    }
}
