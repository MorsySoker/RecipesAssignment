//
//  SearchRecipesView_Tests.swift
//  RecipesAssignmentTests
//
//  Created by MorsyElsokary on 17/10/2022.
//

import XCTest
import Foundation
@testable import RecipesAssignment

final class SearchRecipesView_Tests: XCTestCase {
    
    // MARK: - Properties
    
    var sut: SearchRecipesView!
    
    // MARK: - Setup/Teardown
    
    override func setUp() {
        sut = SearchRecipesView()
        sut.loadViewIfNeeded()
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_SearchRecipesView_displaySearchOrFilterResults_ViewSearchResultsCountShouldMatchTheSentResultsCount() {
        //Given
        let recipesViewModels = [RecipeCellViewModel(imageLink: "", title: "", source: "", healthLabels: "")]
        
        //When
        sut.displaySearchOrFilterResults(recipesViewModels)
        
        //Then
        let recipesCount = sut.searchResults.count
        XCTAssertEqual(recipesViewModels.count, recipesCount)
    }
    
    func test_SearchRecipesView_displaySearchOrFilterResults_ViewShouldDisplayTheResultsIntheTableView() {
        //Given
        let recipesViewModels = [RecipeCellViewModel(imageLink: "", title: "", source: "", healthLabels: "")]
        
        //When
        sut.displaySearchOrFilterResults(recipesViewModels)
        
        //Then
        let rowsCount = sut.recipesTableView.numberOfRows(inSection: 0)
        XCTAssertEqual(recipesViewModels.count, rowsCount)
    }
    
    func test_SearchRecipesView_NoOutletsShouldBeDisConnectedWhenViewDidAppear() {
        
        sut.viewDidLoad()
        
        XCTAssertNotNil(sut.recipesTableView)
        XCTAssertNotNil(sut.healthFilterCollection)
    }
}
