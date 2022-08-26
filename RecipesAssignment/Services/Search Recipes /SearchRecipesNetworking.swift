//
//  SearchRecipesNetworking.swift
//  RecipesAssignment
//
//  Created by MorsyElsokary on 26/08/2022.
//

import Foundation
import Alamofire

protocol SearchRecipesNetworkingProtocol: AnyObject {
    
    func searchRecipes(with query: String,
                       healthLbl: String?,
                       completion: @escaping (Result<BaseResponse<Hit>, AFError>) -> Void)
}

class SearchRecipesNetworking: SearchRecipesNetworkingProtocol {
    
    private let networkService: NetworkServiceProtocol
 
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func searchRecipes(with query: String,
                       healthLbl: String?,
                       completion: @escaping (Result<BaseResponse<Hit>, AFError>) -> Void) {

        networkService.request(SearchRecipesAPI.searchRecipes(query, healthLbl),
                               model: BaseResponse.self,
                               completion: completion)
    }
}
