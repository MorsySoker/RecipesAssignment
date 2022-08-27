//
//  HealthFilters.swift
//  RecipesAssignment
//
//  Created by MorsyElsokary on 27/08/2022.
//

import Foundation

enum HealthFilters: String, CaseIterable {
   
   case all
   case lowSugar = "low-sugar"
   case keto = "keto-friendly"
   case vegan = "vegan"
    
    var text: String {
        switch self {
        case .all: return "All"
        case .lowSugar: return "Low Sugar"
        case .keto: return "Keto"
        case .vegan: return "Vegan"
        }
    }
}

