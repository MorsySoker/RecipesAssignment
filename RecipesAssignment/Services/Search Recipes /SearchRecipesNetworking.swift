//
//  SearchRecipesNetworking.swift
//  RecipesAssignment
//
//  Created by MorsyElsokary on 26/08/2022.
//

import Foundation
import Alamofire

protocol SearchRecipesNetworkingProtocol: AnyObject {
    
    var isLoading: Bool { get }
    
    func searchRecipes(with query: String,
                       healthLbl: String?,
                       from: Int,
                       to: Int,
                       completion: @escaping (Result<BaseResponse<Hit>, AFError>) -> Void)
}

class SearchRecipesNetworking: SearchRecipesNetworkingProtocol {
    
    private(set) lazy var isLoading = false
    private let networkService: NetworkServiceProtocol
 
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func searchRecipes(with query: String,
                       healthLbl: String?,
                       from: Int,
                       to: Int,
                       completion: @escaping (Result<BaseResponse<Hit>, AFError>) -> Void) {
        
        isLoading = true
        networkService.request(SearchRecipesAPI.searchRecipes(query, healthLbl, from, to),
                               model: BaseResponse<Hit>.self) { [unowned self] result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
            self.isLoading = false
        }
    }
}
