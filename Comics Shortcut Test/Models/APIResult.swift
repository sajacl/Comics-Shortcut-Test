//
//  APIResult.swift
//  Comics Shortcut Test
//
//  Created by Sajad Vishkai on 4/5/22.
//

import Foundation

struct APIResult {
    enum Method: String {
        case get
        case post
        case put
        case delete
        case patch
    }
    
    enum Error: LocalizedError {
        case unknown(Swift.Error)
        case invalidResponse
        case statusCode(Int)
        case invalidData
    }
}
