//
//  SearchRecipesViewLogicSpy.swift
//  RecipesAssignmentTests
//
//  Created by MorsyElsokary on 17/10/2022.
//

import Foundation
@testable import RecipesAssignment

class SearchRecipesViewLogicSpy: SearchRecipesViewInput {
    
    func displaySearchOrFilterResults(_ recipes: [RecipesAssignment.RecipeCellViewModel]) {
        
    }
    
    func displayNextPageResults(_ recipes: [RecipesAssignment.RecipeCellViewModel]) {
        
    }
    
    func setSearchSuggestion(_ suggestions: [String]) {
        
    }
    
    func displayError(WithMessage message: String) {
        
    }
}
