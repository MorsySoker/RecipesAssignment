//
//  NetworkError.swift
//  RecipesAssignment
//
//  Created by MorsyElsokary on 18/10/2022.
//

import Foundation

enum NetworkError: Error {
    
    case networkIsLoading
}

extension NetworkError: LocalizedError {
    
     var errorDescription: String? {
        switch self {
        case .networkIsLoading: return NSLocalizedString("Still loading your last request", comment: "") 
        }
    }
}
