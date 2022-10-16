//
//  MockSearchRecipesAPI.swift
//  RecipesAssignmentTests
//
//  Created by MorsyElsokary on 16/10/2022.
//

import Foundation
@testable import RecipesAssignment

enum MockNetworkErrors {
    
    case responseIsNill
}

class MockSearchRecipesAPI: SearchRecipesNetworkingProtocol {
        
    var response: BaseResponse<Hit>?
    var isLoading: Bool
    
    init(recipes: BaseResponse<Hit>?, isLoading: Bool) {
        self.response = recipes
        self.isLoading = isLoading
    }

    func searchRecipes(with query: String, healthLbl: String?, from: Int, to: Int, completion: @escaping (Result<BaseResponse<Hit>, Error>) -> Void) {
        
        DispatchQueue.global().async { [unowned self] in
            if let response {
                completion(.success(response))
            } else {
                completion(.failure(MockNetworkErrors.responseIsNill as! Error))
            }
        }
    }
}
