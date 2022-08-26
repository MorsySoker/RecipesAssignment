//
//  RecipesPresenter.swift
//  RecipesAssignment
//
//  Created by MorsyElsokary on 24/08/2022.
//

import Foundation

protocol SearchRecipesPresenterProtocol: AnyObject {
    
    var searchRecipesView: SearchRecipesViewProtocol? { get set}
    
    func interactor(_ interactor: SearchRecipesInteractorProtocol, didFetchSearchOrFilterResults results: [Recipe])
}

final class SearchRecipesPresenter: SearchRecipesPresenterProtocol {

    // MARK: - Properties
    
    weak var searchRecipesView: SearchRecipesViewProtocol?
    
    // MARK: - Methods
    
    func interactor(_ interactor: SearchRecipesInteractorProtocol, didFetchSearchOrFilterResults results: [Recipe]) {
        
        let recipesViewModels = convertRecipesToRecipeCellViewModels(recipes: results)
        searchRecipesView?.displaySearchOrFilterResults(recipesViewModels)
    }
    
    // MARK: -  Helper Methods
    
    private func convertRecipesToRecipeCellViewModels(recipes: [Recipe])-> [RecipeCellViewModel]
    {
        let resultsViewModels = recipes.compactMap { (recipe) -> RecipeCellViewModel? in
            let healthLabels = recipe.healthLabels.joined(separator: ", ")
            let viewModel = RecipeCellViewModel(imageLink: recipe.image, title: recipe.label, source: recipe.source, healthLabels: healthLabels)
            
            return viewModel
        }
        return resultsViewModels
    }
}
