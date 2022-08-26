//
//  URLRequestBuilder.swift
//  RecipesAssignment
//
//  Created by MorsyElsokary on 25/08/2022.
//

import Alamofire
import Foundation

protocol URLRequestBuilder: URLRequestConvertible, URLConvertible {
    var baseURL: URL { get }
    var path: String { get }
    var requestURL: URL { get }
    var parameters: Parameters? { get }
    var httpMethod: HTTPMethod { get }
    var encoding: ParameterEncoding { get }
    var urlRequest: URLRequest { get }
}

extension URLRequestBuilder {
    
    var baseURL: URL {
        guard let url = URL(string:"https://api.edamam.com")
        else {fatalError("Could not compose the URL")}
                return url
    }
    
    var requestURL: URL {
        baseURL.appendingPathComponent(path, isDirectory: false)
    }
    
    var encoding: ParameterEncoding {
        switch httpMethod {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }

    func asURLRequest() throws -> URLRequest {
        return try encoding.encode(urlRequest, with: parameters)
    }
}
