//
//  BaseResponse.swift
//  RecipesAssignment
//
//  Created by MorsyElsokary on 26/08/2022.
//

import Foundation

struct BaseResponse<Data: Codable>: Codable {
    
    let quary: String?
    var from: Int?
    var to: Int?
    let more: Bool?
    let totalItems: Int?
    var data: [Data]?
    
    enum CodingKeys: String, CodingKey {
        
        case quary = "q"
        case from, to, more
        case totalItems = "count"
        case data = "hits"
    }
}
