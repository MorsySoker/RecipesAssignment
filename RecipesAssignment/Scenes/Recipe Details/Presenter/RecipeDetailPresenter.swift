//
//  RecipeDetailPresenter.swift
//  RecipesAssignment
//
//  Created by MorsyElsokary on 27/08/2022.
//

import Foundation

typealias RecipeDetailPreseneterInput = RecipeDetailInteractorOutput
typealias RecipeDetailPreseneterOutput = RecipeDetailViewOutput

final class RecipeDetailPresenter {
    
    // MARK: - Properties
    
    weak var view: RecipeDetailPreseneterOutput?
    
}

// MARK: - Presenter input Protocol Confrimation

extension RecipeDetailPresenter: RecipeDetailPreseneterInput {
    
    func interactor(_ interactor: RecipeDetailInteractorInput, didFinishSetRecipeDetails recipe: Recipe) {
        
        let recipeDetails = DetailedRecipeViewModel(
            imageLink: recipe.image ?? "",
            title: recipe.label ?? "",
            webSiteLink: recipe.url ?? "",
            ingredients: recipe.ingredientLines ?? [""])
        
        view?.displayRecipeDetails(recipeDetails)
    }
    
    func interactor(_ interactor: RecipeDetailInteractorInput, didGetWebsiteLink link: String) {
        if let url = URL(string: link) {
            view?.openRecipeWebsite(with: url)
        }
    }
    
    func interactor(_ interactor: RecipeDetailInteractorInput, didGetShareLink link: String) {
        if let url = URL(string: link) {
            view?.shareRecipe(with: url)
        }
    }
}
