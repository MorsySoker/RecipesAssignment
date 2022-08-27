//
//  RecipeDetailConfigurator.swift
//  RecipesAssignment
//
//  Created by MorsyElsokary on 27/08/2022.
//

import Foundation

protocol RecipeDetailConfiguratorProtocol {
    
    static func configured(with selectedRecipe: Recipe) -> RecipeDetailView
}

final class RecipeDetailConfigurator: RecipeDetailConfiguratorProtocol {
    
    static func configured(with selectedRecipe: Recipe) -> RecipeDetailView {
        let vc = RecipeDetailView()
        let interactor = RecipeDetailInteractor(recipe: selectedRecipe)
        let presenter = RecipeDetailPresenter()
        let router = RecipeDetailRouter()
        router.view = vc
        presenter.view = vc
        interactor.presetenr = presenter
        vc.interactor = interactor
        vc.router = router
        return vc
    }
}
