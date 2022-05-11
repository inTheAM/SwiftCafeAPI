//
//  Content+Result.swift
//  
//
//  Created by Ahmed Mgua on 20/04/2022.
//

import Vapor

/// A generic wrapper around any return type sent out.
public struct NetworkResponse<WrappedValue: Content>: Content {
    let result: WrappedValue
}

/// Extends Vapor's `Content` protocol with the `NetworkResponse` type.
public extension Content {
    
    typealias APIResult = NetworkResponse<Self>
    
    /// Wraps content in the result of a NetworkResponse
    /// - Returns: A NetworkResponse with a wrapped value of the content.
    func convertToResult() -> APIResult {
        return NetworkResponse(result: self)
    }
}

/// Extends the `APIResult` wrapping to Arrays of types that conform to Vapor's `Content` protocol.
public extension Array where Element: Content {
    typealias APIResult = NetworkResponse<Array<Element>>
    
    func convertToResult() -> APIResult {
        return NetworkResponse(result: self)
    }
}
