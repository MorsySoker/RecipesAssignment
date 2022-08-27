//
//  String+Extension.swift
//  RecipesAssignment
//
//  Created by MorsyElsokary on 26/08/2022.
//

import Foundation

extension String {
    
    // MARK: Text Validation
    
    func isNotEmptyOrSpaces() -> Bool {
        return !self.isEmpty && (self.split(separator: " ")).count > 0
    }
    
}
