//
//  CounterTests.swift
//  CounterTests
//
//  Created by Francisco Cordoba on 22/7/25.
//

import XCTest
@testable import Counter

final class CounterTests: XCTestCase {
    private var sut: CounterViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = CounterViewModel()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testInitialState() {
        // Arrange
        
        // Act
        
        // Assert
        XCTAssertTrue(sut.count == 0)
        XCTAssertTrue(sut.canIncrement)
        XCTAssertTrue(sut.canDecrement)
        XCTAssertFalse(sut.isAtMaximum)
        XCTAssertFalse(sut.isAtMinimum)
    }
    
    func testInitialStateWithCustomValues() {
        // Arrange
        sut = CounterViewModel(count: 10, minCount: -50, maxCount: 50)
        
        // Act
        
        // Assert
        XCTAssertTrue(sut.count == 10)
        XCTAssertTrue(sut.canIncrement)
        XCTAssertTrue(sut.canDecrement)
        XCTAssertFalse(sut.isAtMaximum)
        XCTAssertFalse(sut.isAtMinimum)
    }
    
    func testIncrement() {
        // Arrange
        
        // Act
        sut.increment()
        
        // Assert
        XCTAssertTrue(sut.count == 1)
        XCTAssertTrue(sut.canDecrement)
        XCTAssertTrue(sut.canIncrement)
        XCTAssertFalse(sut.isAtMaximum)
        XCTAssertFalse(sut.isAtMinimum)
    }
    
    func testDecrement() {
        // Arrange
        
        // Act
        sut.decrement()
        
        // Assert
        XCTAssertTrue(sut.count == -1)
        XCTAssertTrue(sut.canDecrement)
        XCTAssertTrue(sut.canIncrement)
        XCTAssertFalse(sut.isAtMaximum)
        XCTAssertFalse(sut.isAtMinimum)
    }
    
    func testReset() {
        // Arrange
        
        // Act
        sut.increment()
        sut.reset()
        
        // Assert
        XCTAssertTrue(sut.count == 0)
        XCTAssertTrue(sut.canDecrement)
        XCTAssertTrue(sut.canIncrement)
        XCTAssertFalse(sut.isAtMaximum)
        XCTAssertFalse(sut.isAtMinimum)
    }
    
    func testMaximumLimit() {
        // Arrange
        sut = CounterViewModel(count: 10, minCount: -11, maxCount: 11)
        
        // Act & Asserts
        sut.increment()
        XCTAssertTrue(sut.count == 11)
        
        sut.increment()
        XCTAssertTrue(sut.count == 11)
        
        XCTAssertFalse(sut.canIncrement)
        XCTAssertTrue(sut.isAtMaximum)
        
        XCTAssertTrue(sut.canDecrement)
        XCTAssertFalse(sut.isAtMinimum)
    }
    
    func testMinimumLimit() {
        // Arrange
        sut = CounterViewModel(count: -10, minCount: -11, maxCount: 11)
        
        // Act & Asserts
        sut.decrement()
        XCTAssertTrue(sut.count == -11)
        
        sut.decrement()
        XCTAssertTrue(sut.count == -11)
        
        XCTAssertTrue(sut.canIncrement)
        XCTAssertFalse(sut.isAtMaximum)
        
        XCTAssertFalse(sut.canDecrement)
        XCTAssertTrue(sut.isAtMinimum)
    }
    
    func testCanIncrementAndDecrementLogic() {
        // Arrange
        sut = CounterViewModel(count: 0, minCount: -1, maxCount: 1)
        
        // Act & Asserts
        XCTAssertTrue(sut.canIncrement)
        XCTAssertTrue(sut.canDecrement)
        
        sut.increment()
        XCTAssertFalse(sut.canIncrement)
        XCTAssertTrue(sut.canDecrement)
        
        sut.decrement()
        XCTAssertTrue(sut.canIncrement)
        XCTAssertTrue(sut.canDecrement)
        
        sut.decrement()
        XCTAssertTrue(sut.canIncrement)
        XCTAssertFalse(sut.canDecrement)
    }
    
    func testResetFromExtremeValues() {
        // Arrange
        sut = CounterViewModel(count: 0, minCount: -10, maxCount: 10)
        
        for _ in 0...10 {
            sut.increment()
        }
        
        XCTAssertTrue(sut.count == 10)
        
        sut.reset()
        XCTAssertTrue(sut.count == 0)
        
        for _ in 0...10 {
            sut.decrement()
        }
        
        XCTAssertTrue(sut.count == -10)
        
        sut.reset()
        XCTAssertTrue(sut.count == 0)
    }
    
    func testConcurrentAccess() async {
        // Arrange
        sut = CounterViewModel(count: 0, minCount: -100, maxCount: 100)
        
        // Act
        await withTaskGroup(of: Void.self) { group in

            for _ in 0..<50 {
                group.addTask {
                    self.sut.increment()
                }
            }
            
            for _ in 0..<30 {
                group.addTask {
                    self.sut.decrement()
                }
            }
        }
        
        // Assert
        // The final count should be 20 (50 increments - 30 decrements)
        XCTAssertEqual(sut.count, 20)
    }
}
