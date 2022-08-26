//
//  RecipesInteractor.swift
//  RecipesAssignment
//
//  Created by MorsyElsokary on 24/08/2022.
//

import Foundation

protocol SearchRecipesInteractorProtocol {
    
    var searchResults: [Recipe] { get }
    
    func search(WithKeyowrd query: String)
}


final class SearchRecipesInteractor: SearchRecipesInteractorProtocol {
    
    // MARK: - Properties
    
    lazy var searchResults: [Recipe] = [Recipe]()
    let serviceNetwork: SearchRecipesNetworkingProtocol
    var presenter: SearchRecipesPresenter?
    
    // MARK: - init
    
    init(serviceNetwork: SearchRecipesNetworkingProtocol) {
        
        self.serviceNetwork = serviceNetwork
    }
    
    // MARK: - Methods
    
    func search(WithKeyowrd query: String) {
        
        let searchKeyword = query.trimmingCharacters(in: .whitespacesAndNewlines)
        
        serviceNetwork.searchRecipes(with: searchKeyword, healthLbl: nil) { [unowned self] result in
            
            switch result {
                
            case .success(let respose):
                self.setInteractorProperties(with: respose)
                print("All Connected BB 🥹")
            case .failure(let error): print(error.errorDescription as Any)
            }
        }
    }
    
    private func setInteractorProperties(with response: BaseResponse<Hit>) {
        
        guard let hits = response.data else {
            return
        }
        
        let recipes = getRecipesFrom(hits: hits)
        searchResults = recipes
        presenter?.interactor(self, didFetchSearchOrFilterResults: recipes)
    }
    
    private func getRecipesFrom(hits: [Hit])-> [Recipe] {
        return hits.compactMap{ $0.recipe }
    }
}
