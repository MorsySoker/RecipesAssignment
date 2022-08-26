//
//  RecipesPresenter.swift
//  RecipesAssignment
//
//  Created by MorsyElsokary on 24/08/2022.
//

import Foundation

final class RecipesPresenter {
    
    // MARK: - Properties
    
    let recipesInteractor: SearchRecipesInteractor
    
    // MARK: - init
    
    init(recipesInteractor: SearchRecipesInteractor) {
        
        self.recipesInteractor = recipesInteractor
    }
    
}
