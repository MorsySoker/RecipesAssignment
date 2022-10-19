//
//  SearchError.swift
//  RecipesAssignment
//
//  Created by MorsyElsokary on 27/08/2022.
//

import Foundation

enum SearchError: Error {
    
    case emptySearch
    case invalidSearchKeyowrd
    case emptySearchSuggestion
    case apiHasNoMoreToOffer
}

extension SearchError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .emptySearch:
            return NSLocalizedString("Empty Search Results, Try Again!", comment: "")
            
        case .invalidSearchKeyowrd:
            return NSLocalizedString("Plese Enter Valid Search Keyword", comment: "")
            
        case .emptySearchSuggestion:
            return NSLocalizedString("empty search suggestion", comment: "")
        case .apiHasNoMoreToOffer:
            return NSLocalizedString("There is no More Recipes we can offer with your search criteria", comment: "")
        }
    }
}
