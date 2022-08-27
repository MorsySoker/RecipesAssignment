//
//  SearchRecipeConfigurator.swift
//  RecipesAssignment
//
//  Created by MorsyElsokary on 26/08/2022.
//

import Foundation

protocol SearchRecipeConfiguratorProtocol {
    
    static func configured() -> SearchRecipesView
}

final class SearchRecipeConfigurator: SearchRecipeConfiguratorProtocol {
    
    static func configured() -> SearchRecipesView {
        
        let vc = SearchRecipesView()
        let service =  SearchRecipesNetworking(
            networkService: NetworkService())
        let suggestionWorker = SearchSuggestionWorker()
        let interactor = SearchRecipesInteractor()
        let presenter = SearchRecipesPresenter()
        let router = SearchRecipeRouter()
        router.view = vc
        presenter.searchRecipesView = vc
        interactor.presenter = presenter
        interactor.serviceNetwork = service
        interactor.searchSuggestionWorker = suggestionWorker
        vc.interactor =  interactor
        vc.router = router
        
        return vc
    }
}
