//
//  RecipesPresenter.swift
//  RecipesAssignment
//
//  Created by MorsyElsokary on 24/08/2022.
//

import Foundation

final class SearchRecipesPresenter {
    
    // MARK: - Properties
    
    weak var searchRecipesView: SearchRecipesPresenterOutput?
    
    // MARK: -  Helper Methods
    
    private func convertRecipesToRecipeCellViewModels(result: BaseResponse<Hit>) -> [RecipeCellViewModel] {

        let recipes = result.data?.map { $0.recipe }
        let resultsViewModels = recipes?.compactMap { (recipe) -> RecipeCellViewModel? in
            let healthLabels = recipe.healthLabels?.joined(separator: ", ")
            let viewModel = RecipeCellViewModel(imageLink: recipe.image ?? "", title: recipe.label ?? "", source: recipe.source ?? "", healthLabels: healthLabels ?? "")
            
            return viewModel
        }
        return resultsViewModels!
    }
}

extension SearchRecipesPresenter: SearchRecipesPresenterInput {
    
    func interactor(_ interactor: SearchRecipesInteractorInput, didFetchSearchOrFilterResults results: BaseResponse<Hit>) {
        
        let recipesViewModels = convertRecipesToRecipeCellViewModels(result: results)
        searchRecipesView?.displaySearchOrFilterResults(recipesViewModels)
    }
    
    func interactor(_ interactor: SearchRecipesInteractorInput, didFetchNextPageResults results: BaseResponse<Hit>) {
        
        let recipesViewModels = convertRecipesToRecipeCellViewModels(result: results)
        searchRecipesView?.displayNextPageResults(recipesViewModels)
    }
    
    func interactor(_ interactor: SearchRecipesInteractorInput, didFetchSearchSuggestions suggestions: [String]) {
        searchRecipesView?.setSearchSuggestion(suggestions)
    }
    
    func interactor(_ interactor: SearchRecipesInteractorInput, didFailWith error: Error) {
        searchRecipesView?.displayError(WithMessage: error.localizedDescription)
    }
}
