//
//  RecipesRespose.swift
//  RecipesAssignment
//
//  Created by MorsyElsokary on 26/08/2022.
//

import Foundation

struct Hit: Codable {
    
    let recipe: Recipe
}

struct Recipe: Codable {
    
    let uri: String?
    let label: String?
    let image: String?
    let source: String?
    let url: String?
    let shareAs: String?
    let yield: Int?
    let healthLabels: [String]?
    let ingredientLines: [String]?
}
