//
//  SearchSuggestionWorker.swift
//  RecipesAssignment
//
//  Created by MorsyElsokary on 27/08/2022.
//

import Foundation

protocol SearchSuggestionWorkerProtocol {
    
    func fetchSuggestions(completion: (Result<[String], Error>) -> Void)
    func saveSuggestions(_ suggestions: [String])
    func addNewSuggestion(_ searchKeywrd: String)-> [String]
}

final class SearchSuggestionWorker {

    // MARK: - Properties
    
    var suggestionArray = SearchSuggestionArray<String>(size: 10)

}

extension SearchSuggestionWorker: SearchSuggestionWorkerProtocol {
    
    // MARK: - Methods
    
    func fetchSuggestions(completion: (Result<[String], Error>) -> Void) {
        guard let searchSuggestions = UserDefaults.standard.array(forKey: "SearchSuggestions") as? [String] else
        {
            completion(.failure(SearchError.emptySearchSuggestion))
            return
        }
        suggestionArray.addItems(items: searchSuggestions)
        completion(.success(searchSuggestions))
    }
    
    func saveSuggestions(_ suggestions: [String]) {
        UserDefaults.standard.setValue(suggestions, forKey: "SearchSuggestions")
    }
    
    func addNewSuggestion(_ searchKeywrd: String) -> [String] {
        return suggestionArray.addAndReturnArray(searchKeywrd)
    }
}
