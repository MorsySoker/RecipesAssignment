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
    
    // MARK: - init
    
    init(serviceNetwork: SearchRecipesNetworkingProtocol){
        self.serviceNetwork = serviceNetwork
        search(WithKeyowrd: "chicken")
    }
    
    // MARK: - Methods
    
    func search(WithKeyowrd query: String) {
        
        let searchKeyword = query.trimmingCharacters(in: .whitespacesAndNewlines)
        
        serviceNetwork.searchRecipes(with: searchKeyword, healthLbl: nil) { [unowned self] result in
            
            switch result {
                
            case .success(let respose): print(respose.totalItems as Any)
            case .failure(let error): print(error.errorDescription as Any)
            }
            
        }
    }
}
