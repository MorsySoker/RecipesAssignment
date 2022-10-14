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
    func interactor(_ interactor: SearchRecipesInteractorInput, didFetchSearchSuggestions suggestions: [String])
    func interactor(_ interactor: SearchRecipesInteractorInput, didFailWith error: Error)
}


final class SearchRecipesInteractor {
    
    // MARK: - Properties
    
    private var from: Int = 0
    private var to: Int = 10
    private var totalItems: Int = 0
    private var hasMore: Bool = true
    private var isAPaginationRequest = false
    private var lastSearchkeyword: String = ""
    private var lastSearchFilter: HealthFilters?
    private lazy var suggestions: [String] = [String]()
    private lazy var searchResults: [Recipe] = [Recipe]()
    var serviceNetwork: SearchRecipesNetworkingProtocol?
    var searchSuggestionWorker: SearchSuggestionWorkerProtocol?
    var presenter: SearchRecipesPresenterInput?
    
    // MARK: - init
    
    init() { getSearchSuggestions() }
}

// MARK: - Interactor Input Confirmation

extension SearchRecipesInteractor: SearchRecipesInteractorInput {
    
    func search(WithKeyowrd query: String) {
        
        let searchKeyword = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard searchKeyword != lastSearchkeyword else { return }
        // Clear The cashed images when the search keyword changes
        ImageService.shared.clearMemoryCache()
        if !suggestions.contains(searchKeyword),
           let suggestionWorker = searchSuggestionWorker {
            suggestions = suggestionWorker.addNewSuggestion(searchKeyword)
            presenter?.interactor(self, didFetchSearchSuggestions: suggestions)
        }
        
        resetPaginationProperties()
        
        serviceNetwork?.searchRecipes(with: searchKeyword,
                                      healthLbl: nil,
                                      from: from,
                                      to: to)
        { [unowned self] result in
            switch result {
            case .success(let respose):
                self.setInteractorProperties(with: respose)
            case .failure(let error):
                presenter?.interactor(self, didFailWith: error)
            }
            lastSearchkeyword = searchKeyword
            isAPaginationRequest = false
        }
    }
    
    func filterResults(WithFilter filter: HealthFilters) {
        
        guard filter != lastSearchFilter else { return }
        let filterRawValue = filter == .all ? nil : filter.rawValue
        resetPaginationProperties()
        
        serviceNetwork?.searchRecipes(with: lastSearchkeyword,
                                      healthLbl: filterRawValue,
                                      from: from,
                                      to: to)
        { [unowned self] result  in
            
            switch result
            {
            case .success(let response):
                setInteractorProperties(with: response)
                
            case .failure(let error):
                presenter?.interactor(self, didFailWith: error)
            }
            isAPaginationRequest = false
            lastSearchFilter = filter
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
    
    private func getSearchSuggestions()
    {
        searchSuggestionWorker?.fetchSuggestions { [unowned self] result in
            switch result {
            case .success(let suggestions):
                self.suggestions = suggestions
                
            case .failure(let error):
                presenter?.interactor(self, didFailWith: error)
            }
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
            presenter?.interactor(self, didFailWith: SearchError.invalidSearchKeyowrd)
            return
        }
        
        guard !hits.isEmpty else {
            
            if isAPaginationRequest { return }
            presenter.interactor(self, didFailWith: SearchError.emptySearch)
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
    
    private func resetPaginationProperties() {
        hasMore = true
        from = 0
        to = 10
        totalItems = 0
    }
    
     func getSearchResult(_ IndexPath: Int) -> Recipe {
        
        searchResults[IndexPath]
    }
}
