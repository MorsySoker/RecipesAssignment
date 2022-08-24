//
//  RecipesPresenter.swift
//  RecipesAssignment
//
//  Created by MorsyElsokary on 24/08/2022.
//

import Foundation

final class RecipesPresenter {
    
    // MARK: - Properties
    
    let recipesInteractor: RecipesInteractor
    
    // MARK: - init
    
    init(recipesInteractor: RecipesInteractor) {
        
        self.recipesInteractor = recipesInteractor
    }
    
}
