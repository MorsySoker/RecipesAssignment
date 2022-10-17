//
//  SearchRecipesInteractorOutputSpy.swift
//  RecipesAssignmentTests
//
//  Created by MorsyElsokary on 16/10/2022.
//

import Foundation
@testable import RecipesAssignment

final class SearchRecipesPresenterLogicSpy: SearchRecipesInteractorOutput {
    
    var didFetchSearchOrFilterResults: Bool = false
    var didFetchNextPageResults: Bool = false
    var didFetchSearchSuggestions: Bool = false
    var didFailWith: Bool = false
    var failedWithError: Error?
    
    func interactor(_ interactor: SearchRecipesInteractorInput, didFetchSearchOrFilterResults results: [RecipesAssignment.Recipe]) {
        didFetchSearchOrFilterResults = true
    }
    
    func interactor(_ interactor: SearchRecipesInteractorInput, didFetchNextPageResults results: [RecipesAssignment.Recipe]) {
        didFetchNextPageResults = true
    }
    
    func interactor(_ interactor: SearchRecipesInteractorInput, didFetchSearchSuggestions suggestions: [String]) {
        didFetchSearchSuggestions = true
    }
    
    func interactor(_ interactor: SearchRecipesInteractorInput, didFailWith error: Error) {
        didFailWith = true
        failedWithError = error
    }
}
