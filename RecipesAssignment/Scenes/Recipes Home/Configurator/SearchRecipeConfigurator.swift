//
//  SearchRecipeConfigurator.swift
//  RecipesAssignment
//
//  Created by MorsyElsokary on 26/08/2022.
//

import Foundation

protocol SearchRecipeConfiguratorProtocol {
    
//    static func configured(_ vc: SearchRecipesView) -> SearchRecipesView
    static func configured() -> SearchRecipesView
}

final class SearchRecipeConfigurator: SearchRecipeConfiguratorProtocol {
    
    static func configured() -> SearchRecipesView {
        
        let vc = SearchRecipesView()
        let service =  SearchRecipesNetworking(
            networkService: NetworkService())
        let interactor = SearchRecipesInteractor()
        let presenter = SearchRecipesPresenter()
        let router = SearchRecipeRouter()
        router.view = vc
        presenter.searchRecipesView = vc
        interactor.presenter = presenter
        interactor.serviceNetwork = service
        vc.interactor =  interactor
        vc.router = router
        
        return vc
    }
}
