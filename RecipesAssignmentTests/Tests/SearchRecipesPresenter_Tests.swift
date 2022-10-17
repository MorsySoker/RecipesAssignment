//
//  SearchRecipesPresenter_Tests.swift
//  RecipesAssignmentTests
//
//  Created by MorsyElsokary on 17/10/2022.
//

import XCTest
@testable import RecipesAssignment

final class SearchRecipesPresenter_Tests: XCTestCase {

    // MARK: - Properties
    
    var sut: SearchRecipesPresenter!
    var interactor: SearchRecipesInteractor!
    var viewSpy: SearchRecipesViewLogicSpy!
    
    // MARK: - Setup/Teardown
    
    override func setUp() {
        sut = SearchRecipesPresenter()
        interactor = SearchRecipesInteractor(searchkeyword: "", searchFilter: .all)
        viewSpy = SearchRecipesViewLogicSpy()
        sut.searchRecipesView = viewSpy
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        interactor = nil
        viewSpy = nil
        super.tearDown()
    }
    
    func test_SearchRecipesPresenter_didFetchSearchOrFilterResults_ViewShouldDisplaySearchOrFilterResults() {
        //When
        sut.interactor(interactor, didFetchSearchOrFilterResults: MockResponse.recipes)
        
        //Then
        XCTAssert(viewSpy.displaySearchOrFilterResults)
    }
    
    func test_SearchRecipesPresenter_didFetchNextPageResults_ViewShouldDisplayNextPageResults() {
        //When
        sut.interactor(interactor, didFetchNextPageResults: MockResponse.recipes)
        
        //Then
        XCTAssert(viewSpy.displayNextPageResults)
    }
    
    func test_SearchRecipesPresenter_didFetchSearchSuggestions_ViewShouldSetSearchSuggestion() {
        //When
        sut.interactor(interactor, didFetchSearchSuggestions: [""])
        
        //Then
        XCTAssert(viewSpy.setSearchSuggestion)
    }
    
    func test_SearchRecipesPresenter_didFailWith_ViewShouldDisplayErrorWithMessage() {
        //When
        sut.interactor(interactor, didFailWith: SearchError.emptySearch)
        
        //Then
        XCTAssert(viewSpy.displayError)
    }
}
