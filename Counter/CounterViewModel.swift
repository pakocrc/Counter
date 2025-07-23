//
//  CounterViewModel.swift
//  Counter
//
//  Created by Francisco Cordoba on 22/7/25.
//

import Observation

@Observable
final class CounterViewModel {
    // MARK: Properties
    private(set) var count: Int
    let maxCount: Int
    let minCount: Int
    
    var canIncrement: Bool {
        count < maxCount
    }
    
    var canDecrement: Bool {
        count > minCount
    }
    
    var isAtMaximum: Bool {
        count == maxCount
    }
    
    var isAtMinimum: Bool {
        count == minCount
    }
    

    // MARK: - Initializer
    init(count: Int = 0, minCount: Int = -100, maxCount: Int = 100) {
        self.count = count
        self.minCount = minCount
        self.maxCount = maxCount
    }
    
    // MARK: -- Actions
    func increment() {
        guard count < maxCount else { return }
        count += 1
    }
    
    func decrement() {
        guard count > minCount else { return }
        count -= 1
    }
    
    func reset() {
        count = 0
    }
    
    deinit {
        print("CounterViewModel deinitialized")
    }
}
