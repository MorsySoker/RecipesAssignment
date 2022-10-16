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
        let sut = SearchRecipesInteractor(lastSearchkeyword: searchKeyword)
        let presenterSpy = SearchRecipesInteractorOutputSpy()
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
        let sut = SearchRecipesInteractor(lastSearchkeyword: lastSearchKeyword)
        let presenterSpy = SearchRecipesInteractorOutputSpy()
        sut.presenter = presenterSpy
        
        // When
        sut.search(WithKeyowrd: searchKeyword)
        
        // Then
        XCTAssertFalse(presenterSpy.didFailWith)
    }
}
