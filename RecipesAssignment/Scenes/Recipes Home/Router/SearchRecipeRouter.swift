//
//  SearchRecipeRouter.swift
//  RecipesAssignment
//
//  Created by MorsyElsokary on 26/08/2022.
//

import Foundation
import UIKit

protocol SearchRecipeRoutingLogic {
    
    func showDetails(for recipe: Recipe)
}

final class SearchRecipeRouter {
    
    // MARK: - Properties
    
    weak var view: UIViewController?
}

extension SearchRecipeRouter: SearchRecipeRoutingLogic {
    
    func showDetails(for recipe: Recipe) {
        print(recipe.source)
    }
}
