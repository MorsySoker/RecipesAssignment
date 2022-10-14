//
//  SearchRecipesProtocols.swift
//  RecipesAssignment
//
//  Created by MorsyElsokary on 14/10/2022.
//

import Foundation

// View Protocols

protocol SearchRecipesViewInput: AnyObject {
    func displaySearchOrFilterResults(_ recipes: [RecipeCellViewModel])
    func displayNextPageResults(_ recipes: [RecipeCellViewModel])
    func setSearchSuggestion(_ suggestions: [String])
    func displayError(WithMessage message: String)
}

protocol SearchRecipesViewOutput: AnyObject {
    func search(WithKeyowrd query: String)
    func filterResults(WithFilter filter: HealthFilters)
    func fetchNextPageForSearchResults()
    func getSearchResult(_ IndexPath: Int) -> Recipe
    func saveSearchSuggestions()
}

// Interactor Protocols

typealias SearchRecipesInteractorInput = SearchRecipesViewOutput

protocol SearchRecipesInteractorOutput {
    func interactor(_ interactor: SearchRecipesInteractorInput, didFetchSearchOrFilterResults results: [Recipe])
    func interactor(_ interactor: SearchRecipesInteractorInput, didFetchNextPageResults results: [Recipe])
    func interactor(_ interactor: SearchRecipesInteractorInput, didFetchSearchSuggestions suggestions: [String])
    func interactor(_ interactor: SearchRecipesInteractorInput, didFailWith error: Error)
}

// Presenter Protocols

typealias SearchRecipesPresenterInput = SearchRecipesInteractorOutput
typealias SearchRecipesPresenterOutput = SearchRecipesViewInput
