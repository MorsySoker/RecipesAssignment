//
//  RecipesInteractor.swift
//  RecipesAssignment
//
//  Created by MorsyElsokary on 24/08/2022.
//

import Foundation

final class SearchRecipesInteractor {
    
    // MARK: - Properties
    
    private var from: Int = 0
    private var to: Int = 10
    private var totalItems: Int = 0
    private var hasMore: Bool = true
    private var isAPaginationRequest = false
    private var lastSearchkeyword: String
    private var lastSearchFilter: HealthFilters?
    private lazy var suggestions: [String] = [String]()
    var searchResult: BaseResponse<Hit>?
    var serviceNetwork: SearchRecipesNetworkingProtocol?
    var searchSuggestionWorker: SearchSuggestionWorkerProtocol?
    var presenter: SearchRecipesPresenterInput?
    
    // MARK: - init
    
    init(searchResult: BaseResponse<Hit>? = nil, searchkeyword: String = "" , searchFilter: HealthFilters = .all) {
        self.searchResult = searchResult
        self.lastSearchkeyword = searchkeyword
        self.lastSearchFilter = searchFilter
        getSearchSuggestions()
    }
}

// MARK: - Interactor Input Confirmation

extension SearchRecipesInteractor: SearchRecipesInteractorInput {
    
    func search(WithKeyowrd query: String) {
        
        let searchKeyword = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard searchKeyword != lastSearchkeyword else {
            presenter?.interactor(self, didFailWith: SearchError.invalidSearchKeyowrd)
            return
        }
        // Clear The cashed images when the search keyword changes
        ImageService.shared.clearMemoryCache()
        if !suggestions.contains(searchKeyword),
           let suggestionWorker = searchSuggestionWorker {
            suggestions = suggestionWorker.addNewSuggestion(searchKeyword)
            presenter?.interactor(self, didFetchSearchSuggestions: suggestions)
        }
        
        resetPaginationProperties()
        
        fetchRecipes(withKeyword: searchKeyword,
                     withFilter: nil,
                     from: from,
                     to: to) { [unowned self] in
            self.lastSearchkeyword = searchKeyword
            self.isAPaginationRequest = false
        }
    }
    
    func filterResults(WithFilter filter: HealthFilters) {
        
        guard filter != lastSearchFilter else { return }
        let filterRawValue = filter == .all ? nil : filter.rawValue
        resetPaginationProperties()
        
        fetchRecipes(withKeyword: lastSearchkeyword,
                     withFilter: filterRawValue,
                     from: from,
                     to: to) { [unowned self] in
            self.isAPaginationRequest = false
            self.lastSearchFilter = filter
        }
    }
    
    func fetchNextPageForSearchResults() {
        guard hasMore,
              let service = serviceNetwork,
              !service.isLoading,
              from + to < totalItems else { return }
        
        from = to
        to = (from + 10) > totalItems ? (totalItems - from ) : ( from + 10 )
        isAPaginationRequest = true
        let filterRawValue = lastSearchFilter == .all ? nil : lastSearchFilter?.rawValue
        
        fetchRecipes(withKeyword: lastSearchkeyword,
                     withFilter: filterRawValue,
                     from: from,
                     to: to) { [unowned self] in
            self.isAPaginationRequest = false
        }
    }
    
    private func getSearchSuggestions() {
        searchSuggestionWorker?.fetchSuggestions { [unowned self] result in
            switch result {
            case .success(let suggestions):
                self.suggestions = suggestions
                presenter?.interactor(self, didFetchSearchSuggestions: suggestions)
            case .failure(let error):
                presenter?.interactor(self, didFailWith: error)
            }
        }
    }
    
    func saveSearchSuggestions() {
        searchSuggestionWorker?.saveSuggestions(suggestions)
    }
    
    func getSearchResult(_ indexPath: Int) -> Recipe {
        getRecipesFrom(response: searchResult!)![indexPath]
    }
    
    // MARK: - Helper Methods
    
    private func fetchRecipes(withKeyword query: String,
                              withFilter filter: String?,
                              from: Int,
                              to: Int,
                              onFinish: @escaping () -> Void) {
        
        serviceNetwork?.searchRecipes(with: query,
                                      healthLbl: filter,
                                      from: from,
                                      to: to)
        { [unowned self] result in
            switch result {
            case .success(let respose):
                self.setInteractorProperties(with: respose)
            case .failure(let error):
                presenter?.interactor(self, didFailWith: error)
            }
            onFinish()
        }
    }
    
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
        
        if isAPaginationRequest {
            searchResult = appendNewHits(response: response)
            presenter.interactor(self, didFetchNextPageResults: searchResult!)
        } else {
            searchResult = response
            presenter.interactor(self, didFetchSearchOrFilterResults: response)
        }
    }
    
    private func appendNewHits(response: BaseResponse<Hit>) -> BaseResponse<Hit> {
        if let newHits = response.data, searchResult != nil, var oldHits = searchResult!.data {
            oldHits.append(contentsOf: newHits)
            return BaseResponse<Hit>(quary: response.quary,
                                     from: response.from,
                                     to: response.to,
                                     more: response.more,
                                     totalItems: response.totalItems,
                                     data: oldHits)
        }
        return response
    }
    
    private func getRecipesFrom(response: BaseResponse<Hit>) -> [Recipe]? {
        if let hits = response.data {
           return hits.map { $0.recipe }
        }
        return nil
    }
    
    private func resetPaginationProperties() {
        hasMore = true
        from = 0
        to = 10
        totalItems = 0
    }
}
