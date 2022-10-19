//
//  SearchRecipesInteractorLogicSpy.swift
//  RecipesAssignmentTests
//
//  Created by MorsyElsokary on 17/10/2022.
//

import Foundation
@testable import RecipesAssignment

final class SearchRecipesInteractorLogicSpy: SearchRecipesInteractorInput {

    var isSearchWithKeyowrdCalled: Bool = false
    var isFilterResultsWithFilterCalled: Bool = false
    var isFetchNextPageForSearchResultsCalled: Bool = false
    var isGetSearchResultAtIndexPathCalled: Bool = false
    var isSaveSearchSuggestionsCalled: Bool = false
    
    func search(WithKeyowrd query: String, completion: (() -> Void)?) {
        isSearchWithKeyowrdCalled = true
    }
    
    func filterResults(WithFilter filter: HealthFilters, completion: (() -> Void)?) {
        isFilterResultsWithFilterCalled = true
    }
    
    func fetchNextPageForSearchResults(completion: (() -> Void)?) {
        isFetchNextPageForSearchResultsCalled = true
    }
    
    func getSearchResult(_ IndexPath: Int) -> RecipesAssignment.Recipe {
        isGetSearchResultAtIndexPathCalled = true
        return MockResponse.recipes[IndexPath]
    }
    
    func saveSearchSuggestions() {
        isSaveSearchSuggestionsCalled = true
    }
}
