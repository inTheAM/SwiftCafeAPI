//
//  File.swift
//  
//
//  Created by Ahmed Mgua on 20/04/2022.
//

import Vapor

struct NetworkResponse<WrappedValue: Content>: Content {
    let result: WrappedValue
}

extension Content {
    typealias APIResult = NetworkResponse<Self>
    
    func convertToResult() -> APIResult {
        return NetworkResponse(result: self)
    }
    
}

extension Array where Element: Content {
    typealias APIResult = NetworkResponse<Array<Element>>
    func convertToResult() -> APIResult {
        return NetworkResponse(result: self)
    }
}
