//
//  MockResponse.swift
//  RecipesAssignmentTests
//
//  Created by MorsyElsokary on 16/10/2022.
//

import Foundation
@testable import RecipesAssignment

struct MockResponse {
    
    static let response = BaseResponse(quary: "Pizza",
                                       from: 0,
                                       to: 1,
                                       more: true,
                                       totalItems: 10,
                                       data: [Hit(recipe: Recipe(uri: nil,
                                                                 label: nil,
                                                                 image: nil,
                                                                 source: nil,
                                                                 url: nil,
                                                                 shareAs: nil,
                                                                 yield: nil,
                                                                 healthLabels: nil,
                                                                 ingredientLines: nil))])
    
    static var nextPageResponse = BaseResponse(quary: "Pizza",
                                               from: 1,
                                               to: 2,
                                               more: true,
                                               totalItems: 10,
                                               data: [Hit(recipe: Recipe(uri: nil,
                                                                         label: nil,
                                                                         image: nil,
                                                                         source: nil,
                                                                         url: nil,
                                                                         shareAs: nil,
                                                                         yield: nil,
                                                                         healthLabels: nil,
                                                                         ingredientLines: nil))])
    
    static let nilResponse = BaseResponse(quary: "Pizza",
                                          from: nil,
                                          to: nil,
                                          more: nil,
                                          totalItems: nil,
                                          data: [Hit(recipe: Recipe(uri: nil,
                                                                    label: nil,
                                                                    image: nil,
                                                                    source: nil,
                                                                    url: nil,
                                                                    shareAs: nil,
                                                                    yield: nil,
                                                                    healthLabels: nil,
                                                                    ingredientLines: nil))])
    
    static let emptyHitResponse = BaseResponse<Hit>(quary: "", from: 0, to: 10, more: true, totalItems: 7000, data: [])
    
    static let recipes = [Recipe(uri: nil,
                                 label: nil,
                                 image: nil,
                                 source: nil,
                                 url: nil,
                                 shareAs: nil,
                                 yield: nil,
                                 healthLabels: nil,
                                 ingredientLines: nil)]
}
