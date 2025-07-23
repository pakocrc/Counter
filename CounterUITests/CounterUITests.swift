//
//  CounterUITests.swift
//  CounterUITests
//
//  Created by Francisco Cordoba on 22/7/25.
//

import XCTest

final class CounterUITests: XCTestCase {
    private var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app = nil
    }
    
    func testCounterInitialState() {
        // Arrange
        let title = app.staticTexts["counter-title"]
        let counterValue = app.staticTexts["counter-value"]
        let incrementButton = app.buttons["increment-button"]
        let decrementButton = app.buttons["decrement-button"]
        let resetButton = app.buttons["reset-button"]
        
        // Act
        
        // Assert
        XCTAssertTrue(title.exists)
        XCTAssertTrue(counterValue.exists)
        XCTAssertTrue(incrementButton.exists)
        XCTAssertTrue(decrementButton.exists)
        XCTAssertTrue(resetButton.exists)
        
        XCTAssertEqual(counterValue.label, "0")
        XCTAssertTrue(incrementButton.isEnabled)
        XCTAssertTrue(decrementButton.isEnabled)
    }
    
    func testIncrementCounter() {
        // Arrange
        let counterValue = app.staticTexts["counter-value"]
        let incrementButton = app.buttons["increment-button"]
        
        // Act & Assert
        XCTAssertEqual(counterValue.label, "0")
        
        incrementButton.tap()
        XCTAssertEqual(counterValue.label, "1")
        
        incrementButton.tap()
        incrementButton.tap()
        XCTAssertEqual(counterValue.label, "3")
    }
    
    func testDecrementCounter() {
        // Arrange
        let counterValue = app.staticTexts["counter-value"]
        let decrementButton = app.buttons["decrement-button"]
        
        // Act & Assert
        
        XCTAssertEqual(counterValue.label, "0")
        
        decrementButton.tap()
        XCTAssertEqual(counterValue.label, "-1")
        
        decrementButton.tap()
        decrementButton.tap()
        XCTAssertEqual(counterValue.label, "-3")
    }
    
    func testResetCounter() {
        // Arrange
        let counterValue = app.staticTexts["counter-value"]
        let incrementButton = app.buttons["increment-button"]
        let resetButton = app.buttons["reset-button"]
        
        // Act & Assert
        XCTAssertEqual(counterValue.label, "0")
        
        incrementButton.tap()
        incrementButton.tap()
        incrementButton.tap()
        XCTAssertEqual(counterValue.label, "3")
        
        resetButton.tap()
        
        XCTAssertEqual(counterValue.label, "0")
    }
    
    func testCounterLimits() {
        // Arrange
        let counterValue = app.staticTexts["counter-value"]
        let incrementButton = app.buttons["increment-button"]
        let decrementButton = app.buttons["decrement-button"]
        let maxValueLabel = app.staticTexts["max-value-label"]
        let minValueLabel = app.staticTexts["min-value-label"]
        let resetbutton = app.buttons["reset-button"]
        
        // Act & Assert
        XCTAssertEqual(counterValue.label, "0")
        
        for _ in 0..<105 {
            incrementButton.tap()
        }
        
        XCTAssertEqual(counterValue.label, "100")
        XCTAssertFalse(incrementButton.isEnabled)
        XCTAssertTrue(maxValueLabel.exists)
        
        resetbutton.tap()
        
        for _ in 0..<105 {
            decrementButton.tap()
        }
        
        XCTAssertEqual(counterValue.label, "-100")
        XCTAssertFalse(decrementButton.isEnabled)
        XCTAssertTrue(minValueLabel.exists)
    }
    
    func testMixedOperations() {
        // Arrange
        let counterValue = app.staticTexts["counter-value"]
        let incrementButton = app.buttons["increment-button"]
        let decrementButton = app.buttons["decrement-button"]
        
        // Act & Assert
        XCTAssertEqual(counterValue.label, "0")
        
        incrementButton.tap()
        incrementButton.tap()
        incrementButton.tap()
        
        XCTAssertEqual(counterValue.label, "3")
        
        decrementButton.tap()
        decrementButton.tap()
        
        XCTAssertEqual(counterValue.label, "1")
        
        incrementButton.tap()
        decrementButton.tap()
        decrementButton.tap()
        decrementButton.tap()
        
        XCTAssertEqual(counterValue.label, "-1")
    }
}
