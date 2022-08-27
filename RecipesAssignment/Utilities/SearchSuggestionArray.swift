//
//  SearchSuggestionArray.swift
//  RecipesAssignment
//
//  Created by MorsyElsokary on 27/08/2022.
//

import Foundation

/// This is a helper calss used in Search auto suggesstion feature

public struct SearchSuggestionArray<T> {
    
    // MARK: - Properties
    
    private (set) var array: [T?]
    private (set) var currentItems = 0
    private var maximumSize = 0
    
    // MARK: - init
    
    public init(size: Int) {
        self.array = [T?](repeating: nil, count: size)
        self.maximumSize = size
    }
    
    // MARK: - Methods
    
    public mutating func addItems(items: [T]) {
        
        array = items
        currentItems = items.count
    }
    
    /// This function add new element at the first of array and if the currentItems is equal to array max size (in our case max size is 10 elements) we remove last element (the oldest search suggestion) to make space for the new element.
    public mutating func addAndReturnArray(_ element: T) -> [T] {
        
        if currentItems < maximumSize {
            currentItems += 1
        }
        else {
            array.removeLast()
        }
        array.insert(element, at: 0)
        return array.compactMap{$0}
    }
}
