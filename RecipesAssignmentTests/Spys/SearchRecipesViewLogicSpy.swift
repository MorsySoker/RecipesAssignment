//
//  SearchRecipesViewLogicSpy.swift
//  RecipesAssignmentTests
//
//  Created by MorsyElsokary on 17/10/2022.
//

import Foundation
@testable import RecipesAssignment

final class SearchRecipesViewLogicSpy: SearchRecipesViewInput {
    
    var displaySearchOrFilterResults: Bool = false
    var displayNextPageResults: Bool = false
    var setSearchSuggestion: Bool = false
    var displayError: Bool = false
    
    func displaySearchOrFilterResults(_ recipes: [RecipesAssignment.RecipeCellViewModel]) {
        displaySearchOrFilterResults = true
    }
    
    func displayNextPageResults(_ recipes: [RecipesAssignment.RecipeCellViewModel]) {
        displayNextPageResults = true
    }
    
    func setSearchSuggestion(_ suggestions: [String]) {
        setSearchSuggestion = true
    }
    
    func displayError(WithMessage message: String) {
        displayError = true
    }
}
