//
//  RecipesInteractor.swift
//  RecipesAssignment
//
//  Created by MorsyElsokary on 24/08/2022.
//

import Foundation

typealias SearchRecipesInteractorInput = SearchRecipesViewOutput

protocol SearchRecipesInteractorOutput {
    
    func interactor(_ interactor: SearchRecipesInteractorInput, didFetchSearchOrFilterResults results: [Recipe])
    func interactor(_ interactor: SearchRecipesInteractorInput, didFetchNextPageResults results: [Recipe])
}


final class SearchRecipesInteractor {
    
    // MARK: - Properties
    private var from: Int = 0
    private var to: Int = 10
    private var totalItems: Int = 0
    private var hasMore: Bool = true
    private var isAPaginationRequest = false
    private var lastSearchkeyword: String = ""
    lazy var searchResults: [Recipe] = [Recipe]()
    var serviceNetwork: SearchRecipesNetworkingProtocol?
    var presenter: SearchRecipesPresenterInput?
}

// MARK: - Interactor Input Confirmation

extension SearchRecipesInteractor: SearchRecipesInteractorInput {
    
    func search(WithKeyowrd query: String) {
        
        let searchKeyword = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard searchKeyword != lastSearchkeyword else { return }
        
        resetInteractorProperties()
        
        serviceNetwork?.searchRecipes(with: searchKeyword,
                                     healthLbl: nil,
                                     from: from,
                                     to: to)
        { [unowned self] result in
            switch result {
            case .success(let respose):
                self.setInteractorProperties(with: respose)
            case .failure(let error): print(error.errorDescription as Any)
            }
            lastSearchkeyword = searchKeyword
            isAPaginationRequest = false
        }
    }
    
    func fetchNextPageForSearchResults() {
        
        guard hasMore,
              let service = serviceNetwork,
              !service.isLoading,
              from + to < totalItems else {
            return
        }
        
        from = to
        to = (from + 10) > totalItems ? (totalItems - from ) : ( from + 10 )
        isAPaginationRequest = true
        
        service.searchRecipes(with: lastSearchkeyword,
                                     healthLbl: nil,
                                     from: from,
                                     to: to)
        { [unowned self] result in
            switch result {
            case .success(let respose):
                self.setInteractorProperties(with: respose)
            case .failure(let error):
                print(error.errorDescription as Any)
            }
            isAPaginationRequest = false
        }
    }
    
    // MARK: - Helper Methods
    
    private func setInteractorProperties(with response: BaseResponse<Hit>) {
        
        guard let hits = response.data,
              let presenter = presenter,
              let hasMore = response.more,
              let to = response.to,
              let from = response.from,
              let totalItems = response.totalItems else {
            return
        }
        
        guard !hits.isEmpty else {
            return
        }
        
        self.hasMore =  hasMore
        self.to = to
        self.from = from
        self.totalItems = totalItems
        
        let recipes = getRecipesFrom(hits: hits)
        
        if isAPaginationRequest {
            searchResults.append(contentsOf: recipes)
            presenter.interactor(self, didFetchNextPageResults: searchResults)
        } else {
            searchResults = recipes
            presenter.interactor(self, didFetchSearchOrFilterResults: searchResults)
        }
    }
    
    private func getRecipesFrom(hits: [Hit])-> [Recipe] {
        return hits.compactMap{ $0.recipe }
    }
    
    private func resetInteractorProperties() {
        hasMore = true
        from = 0
        to = 10
        totalItems = 0
    }
}
