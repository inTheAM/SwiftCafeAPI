//
//  File.swift
//  
//
//  Created by Ahmed Mgua on 06/05/2022.
//

import Vapor

/// # The result of a request with no return type.
public enum RequestResult: Content {
    case success, failure
}
