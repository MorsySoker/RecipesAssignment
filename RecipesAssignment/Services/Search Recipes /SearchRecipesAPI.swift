//
//  SearchRecipesAPI.swift
//  RecipesAssignment
//
//  Created by MorsyElsokary on 26/08/2022.
//

import Foundation
import Alamofire

enum SearchRecipesAPI {
    
    case searchRecipes(_ query: String, _ healthLbl: String?, _ from: Int, _ to: Int)
}

extension SearchRecipesAPI: URLRequestBuilder {
    var path: String {
        switch self {
        case .searchRecipes: return "search"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .searchRecipes(let query, let healthlbl, let from, let to):
            
            if let healthlbl = healthlbl {
                return ["q" : query,
                        "health" : healthlbl,
                        "app_id" : AppAuthKeys.appId,
                        "app_key" : AppAuthKeys.appKey,
                        "from" : from,
                        "to" : to]
            } else {
                return ["q" : query,
                        "app_id" : AppAuthKeys.appId,
                        "app_key" : AppAuthKeys.appKey,
                        "from" : from,
                        "to" : to]
            }
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .searchRecipes: return .get
        }
    }
    
    var urlRequest: URLRequest {
        var request = URLRequest(url: requestURL)
        request.httpMethod = httpMethod.rawValue
        return request
    }
    
    func asURL() throws -> URL {
        requestURL
    }
}
