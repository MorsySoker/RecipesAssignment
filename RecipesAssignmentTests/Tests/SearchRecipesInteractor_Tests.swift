//
//  SearchRecipesInteractor_Tests.swift
//  RecipesAssignmentTests
//
//  Created by MorsyElsokary on 14/10/2022.
//

import XCTest
@testable import RecipesAssignment

final class SearchRecipesInteractor_Tests: XCTestCase {

    // MARK: - Properties
    
    var sut: SearchRecipesInteractor!
    
    // MARK: - Setup/Teardown
    
    override func setUp() {
         
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_SearchRecipesInteractor_searchWithKeyword_PresenterShouldReciveAFailWhenTheSearchKeyWordDidntChange() {
        
        // Given
        let searchKeyword = UUID().uuidString
        let sut = SearchRecipesInteractor(searchkeyword: searchKeyword, searchFilter: .all)
        let presenterSpy = SearchRecipesPresenterLogicSpy()
        sut.presenter = presenterSpy
        
        // When
        sut.search(WithKeyowrd: searchKeyword)
        
        // Then
        XCTAssert(presenterSpy.didFailWith)
        XCTAssertEqual(presenterSpy.failedWithError as? SearchError, SearchError.invalidSearchKeyowrd)
    }
    
    func test_SearchRecipesInteractor_searchWithKeyword_PresenterShouldNotReciveAFailWhenTheSearchKeyWordDoChange() {
        
        // Given
        let lastSearchKeyword = UUID().uuidString
        let searchKeyword = UUID().uuidString
        let sut = SearchRecipesInteractor(searchkeyword: lastSearchKeyword, searchFilter: .all)
        let presenterSpy = SearchRecipesPresenterLogicSpy()
        sut.presenter = presenterSpy
        
        // When
        sut.search(WithKeyowrd: searchKeyword)
        
        // Then
        XCTAssertFalse(presenterSpy.didFailWith)
    }
    
    func test_SearchRecipesInteractor_setInteractorProperties_PresenterShouldReciveAFailWhenTheResposeIsNil() {
        
        // Given
        let lastSearchKeyword = UUID().uuidString
        let searchKeyword = UUID().uuidString
        let sut = SearchRecipesInteractor(searchkeyword: lastSearchKeyword, searchFilter: .all)
        let presenterSpy = SearchRecipesPresenterLogicSpy()
        let mockedService = MockSearchRecipesAPI(recipes: MockResponse.nilResponse, isLoading: false)
        sut.presenter = presenterSpy
        sut.serviceNetwork = mockedService
        let expectation = self.expectation(description: "Presenter Should Fail with invalid Search Keyowrd")
        // When
        sut.search(WithKeyowrd: searchKeyword)
        expectation.fulfill()
        // Then
        waitForExpectations(timeout: 5)
        XCTAssert(presenterSpy.didFailWith)
        XCTAssertEqual(presenterSpy.failedWithError as? SearchError, SearchError.invalidSearchKeyowrd)
    }
    
    func test_SearchRecipesInteractor_setInteractorProperties_PresenterShouldReciveAFailWhenTheHitsArrayIsEmpty() {
        
        // Given
        let lastSearchKeyword = UUID().uuidString
        let searchKeyword = UUID().uuidString
        let sut = SearchRecipesInteractor(searchkeyword: lastSearchKeyword, searchFilter: .all)
        let presenterSpy = SearchRecipesPresenterLogicSpy()
        let mockedService = MockSearchRecipesAPI(recipes: MockResponse.emptyHitResponse, isLoading: false)
        sut.presenter = presenterSpy
        sut.serviceNetwork = mockedService
        let expectation = self.expectation(description: "Presenter Should Fail When Hits Array is Empty")
        // When
        sut.search(WithKeyowrd: searchKeyword)
        expectation.fulfill()
        // Then
        waitForExpectations(timeout: 5)
        XCTAssert(presenterSpy.didFailWith)
        XCTAssertEqual(presenterSpy.failedWithError as? SearchError, SearchError.emptySearch)
    }
    
    func test_SearchRecipesInteractor_setInteractorProperties_PresenterShouldReciveTheResonseWhenTheRecipesIsFetchedThrowSearch() {
        
        // Given
        let lastSearchKeyword = UUID().uuidString
        let searchKeyword = UUID().uuidString
        let sut = SearchRecipesInteractor(searchkeyword: lastSearchKeyword, searchFilter: .all)
        let presenterSpy = SearchRecipesPresenterLogicSpy()
        let mockedService = MockSearchRecipesAPI(recipes: MockResponse.response, isLoading: false)
        sut.presenter = presenterSpy
        sut.serviceNetwork = mockedService
        let expectation = self.expectation(description: "Presenter Should Recive Recipes when search with Keyword Finish successfully")
        // When
        sut.search(WithKeyowrd: searchKeyword)
        expectation.fulfill()
        // Then
        waitForExpectations(timeout: 5)
        XCTAssert(presenterSpy.didFetchSearchOrFilterResults)
    }
}
