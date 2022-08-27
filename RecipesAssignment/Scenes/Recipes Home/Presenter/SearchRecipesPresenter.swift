//
//  RecipesPresenter.swift
//  RecipesAssignment
//
//  Created by MorsyElsokary on 24/08/2022.
//

import Foundation

typealias SearchRecipesPresenterInput = SearchRecipesInteractorOutput
typealias SearchRecipesPresenterOutput = SearchRecipesViewInput

final class SearchRecipesPresenter {
    
    // MARK: - Properties
    
    weak var searchRecipesView: SearchRecipesPresenterOutput?
    
    // MARK: -  Helper Methods
    
    private func convertRecipesToRecipeCellViewModels(recipes: [Recipe])-> [RecipeCellViewModel] {
        
        
        let resultsViewModels = recipes.compactMap { (recipe) -> RecipeCellViewModel? in
            let healthLabels = recipe.healthLabels?.joined(separator: ", ")
            let viewModel = RecipeCellViewModel(imageLink: recipe.image!, title: recipe.label ?? "", source: recipe.source ?? "", healthLabels: healthLabels ?? "")
            
            return viewModel
        }
        return resultsViewModels
    }
}

extension SearchRecipesPresenter: SearchRecipesPresenterInput {
    
    func interactor(_ interactor: SearchRecipesInteractorInput, didFetchSearchOrFilterResults results: [Recipe]) {
        
        let recipesViewModels = convertRecipesToRecipeCellViewModels(recipes: results)
        searchRecipesView?.displaySearchOrFilterResults(recipesViewModels)
    }
    
    func interactor(_ interactor: SearchRecipesInteractorInput, didFetchNextPageResults results: [Recipe]) {
        
        let recipesViewModels = convertRecipesToRecipeCellViewModels(recipes: results)
        searchRecipesView?.displayNextPageResults(recipesViewModels)
    }
}
