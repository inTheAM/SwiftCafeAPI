//
//  Location.swift
//  
//
//  Created by Ahmed Mgua on 20/04/2022.
//

import Vapor

struct Location:    Content {
    var latitude:   Double
    var longitude:  Double
}

extension Location: Equatable {
    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
