//
//  Compass_TestTests.swift
//  Compass TestTests
//
//  Created by Martin De Simone on 31/05/2024.
//

@testable import Compass_Test

import XCTest

final class Compass_TestTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWordManager() async throws {
        let failureWorkManager = AppWordManager(wordRepository: MockWordFailureRepository())
        let successWordManager = AppWordManager(wordRepository: MockWordSuccessRepository())

        
        let firstResult = await failureWorkManager.fetchEvery10Character()
        XCTAssert(firstResult.isEmpty, "fetchEvery10Character should be empty")
        
        let secondResult = await successWordManager.fetchEvery10Character()
        XCTAssert(!secondResult.isEmpty, "fetchEvery10Character result should not be empty")
        
        let thirdResult = await failureWorkManager.fetchWordCounter()
        XCTAssert(thirdResult.isEmpty, "fetchWordCounter should be empty")
        
        let fourthResult = await successWordManager.fetchWordCounter()
        XCTAssert(!fourthResult.isEmpty, "fetchWordCounter result should not be empty")
        
        let fifthResult = await failureWorkManager.fetchWords()
        XCTAssert(fifthResult == nil, "fetchWords should be nil")
        
        let sixResult = await successWordManager.fetchWords()
        XCTAssert(sixResult != nil, "fetchWords should not be nil")
    }
    

    func testMainViewModel() async throws {
        let viewModel = MainViewModel(wordsManager: MockSuccessWordManager())
        await viewModel.fetchData()
        
        XCTAssert(!viewModel.characterList.isEmpty, "characterList should not be empty")
        XCTAssert(!viewModel.wordCount.isEmpty, "wordCount should not be empty")
        XCTAssert(!viewModel.wordList.isEmpty, "wordList should not be empty")
        
        let failureViewModel = MainViewModel(wordsManager: MockFailureWordManager())
        await failureViewModel.fetchData()
        
        XCTAssert(failureViewModel.characterList.isEmpty, "characterList should be empty")
        XCTAssert(failureViewModel.wordCount.isEmpty, "wordCount should be empty")
        XCTAssert(failureViewModel.wordList.isEmpty, "wordList should be empty")
    }

}
