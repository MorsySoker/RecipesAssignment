//
//  NetworkService.swift
//  RecipesAssignment
//
//  Created by MorsyElsokary on 25/08/2022.
//

import Foundation
import Alamofire

protocol NetworkServiceProtocol {
    
    func request<Model: Codable, Request: URLRequestBuilder>(
        _ urlRequest: Request,
        model: Model.Type,
        completion: @escaping (Result<Model, AFError>) -> Void)
}


class NetworkService: NetworkServiceProtocol, ObservableObject {
    
    // MARK: - request
    
    func request<Model: Codable, Request: URLRequestBuilder>(_ urlRequest: Request,
                                 model: Model.Type,
                                 completion: @escaping (Result<Model, AFError>) -> Void) {
        
        #if DEBUG
        print("🚀", urlRequest.httpMethod.rawValue, urlRequest.requestURL ,urlRequest.urlRequest.headers,
              "🔑", urlRequest.parameters ?? "")
       #endif
        
        AF.request(urlRequest)
            .responseDecodable(of: model.self,
                               queue: .main,
                               decoder: JSONDecoder()) { result in
                #if DEBUG
                if result.response?.statusCode == 401 {
                    print("❌ Unauthorized")
                }
                if result.response?.statusCode == 400 {
                    print("❌ Bad Request")
                }
//                print(result.request as Any)  // original URL request
//                print(result.response as Any) // URL response
//                print(String(data: result.data ?? Data() , encoding: .utf8) as Any)// server data
//                print(result.result)   // result of response serialization
//                print("🎯 \(String(describing: result.value))")
                #endif
                if let value = result.value { completion(Result.success(value)) }
                else if let error = result.error { completion(Result.failure(error)) }
            }
    }
}
