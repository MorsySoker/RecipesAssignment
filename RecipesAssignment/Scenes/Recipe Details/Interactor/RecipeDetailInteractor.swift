//
//  RecipeDetailInteractor.swift
//  RecipesAssignment
//
//  Created by MorsyElsokary on 27/08/2022.
//

import Foundation

typealias RecipeDetailInteractorInput = RecipeDetailViewInput

protocol RecipeDetailInteractorOutput: AnyObject {
    
    func interactor(_ interactor: RecipeDetailInteractorInput, didFinishSetRecipeDetails recipe: Recipe)
    func interactor(_ interactor: RecipeDetailInteractorInput,
                    didGetWebsiteLink link: String)
    func interactor(_ interactor: RecipeDetailInteractorInput,
                    didGetShareLink link: String)
}

final class RecipeDetailInteractor {
    
    // MARK: - Properties
    
    private(set) var recipe: Recipe
    var presetenr: RecipeDetailInteractorOutput?
    
    // MARK: - init
    init(recipe: Recipe) {
        
        self.recipe = recipe
    }
}

// MARK: - Interactor input Protocol Confrimation

extension RecipeDetailInteractor: RecipeDetailInteractorInput {
    func getSelectedRecipeDetails() {
        
        presetenr?.interactor(self, didFinishSetRecipeDetails: recipe)
    }
    
    func goToRecipeWebsite() {
        if let recipeWebsiteLink = recipe.url {
            presetenr?.interactor(self, didGetWebsiteLink: recipeWebsiteLink)
        }
    }
    
    func shareRecipe() {
        if let recipeShareAs = recipe.shareAs {
            presetenr?.interactor(self, didGetShareLink: recipeShareAs)
        }
        
    }
}
