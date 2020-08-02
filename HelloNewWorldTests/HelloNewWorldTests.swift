//
//  HelloNewWorldTests.swift
//  HelloNewWorldTests
//
//  Created by Andrew Allen on 26/07/2020.
//  Copyright © 2020 Andrew Allen. All rights reserved.
//

import XCTest
@testable import HelloNewWorld

class HelloNewWorldTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    // MARK: Meal Class Tests
    func testMealInitialisationSuceeds() {
        // Confirm that the Meal initialiser returns a Meal object when passed valid
        // parameters.
        
        // zero rating
        let zeroRatingMeal = Meal.init(name: "Zero", photo: nil, rating: 0)
        XCTAssertNotNil(zeroRatingMeal)
        
        // highest postitive rating
        let highestRatingMeal = Meal.init(name: "Highest", photo: nil, rating: 5)
        XCTAssertNotNil(highestRatingMeal)
    }
    
    func testMealInitialisationFails() {
        // Confirms that the Meal initialiser returns nil when passed
        // invalid parameters
        
        // negative rating
        let negativeRatingMeal = Meal.init(name: "Negative", photo: nil, rating: -1)
        XCTAssertNil(negativeRatingMeal)
        
        // empty string
        let emptyStringMeal = Meal.init(name: "", photo: nil, rating: 0)
        XCTAssertNil(emptyStringMeal)
        
        // rating exceeds maximum
        let largeRatingMeal = Meal.init(name: "Large", photo: nil, rating: 6)
        XCTAssertNil(largeRatingMeal)
    }

}
