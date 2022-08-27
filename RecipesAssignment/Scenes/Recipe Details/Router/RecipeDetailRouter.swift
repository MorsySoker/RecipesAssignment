//
//  RecipeDetailRouter.swift
//  RecipesAssignment
//
//  Created by MorsyElsokary on 27/08/2022.
//

import Foundation
import UIKit

protocol RecipeDetailRoutingLogic {
    
    func popToSearchRecipe()
}

final class RecipeDetailRouter {
    
    // MARK: - Properties
    
    weak var view: UIViewController?
    
}

extension RecipeDetailRouter: RecipeDetailRoutingLogic {
    
    func popToSearchRecipe() {
        view?.navigationController?.popViewController(animated: true)
    }
}
