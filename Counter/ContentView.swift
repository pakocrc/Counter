//
//  ContentView.swift
//  Counter
//
//  Created by Francisco Cordoba on 22/7/25.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = CounterViewModel()

    var body: some View {
        VStack(spacing: 30) {
            Text("Counter")
                .font(.largeTitle)
                .fontWeight(.bold)
                .accessibilityIdentifier("counter-title")
            
            Text("\(viewModel.count)")
                .font(.system(size: 72, weight: .light, design: .monospaced))
                .foregroundColor(colorForCount())
                .accessibilityIdentifier("counter-value")
                .accessibilityLabel("\(viewModel.count)")
            
            HStack {
                Button(action: { viewModel.decrement() }) {
                    Image(systemName: "minus.circle.fill")
                        .font(.system(size: 44))
                        .foregroundColor(viewModel.canDecrement ? .blue : .gray)
                }
                .disabled(!viewModel.canDecrement)
                .accessibilityIdentifier("decrement-button")
                .accessibilityLabel("Decrement button")
                
                Spacer()
                
                Button(action: { viewModel.increment() }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 44))
                        .foregroundColor(viewModel.canIncrement ? .blue : .gray)
                }
                .disabled(!viewModel.canIncrement)
                .accessibilityIdentifier("increment-button")
                .accessibilityLabel("Increment button")
            }
            .padding([.horizontal], 75)
            
            Button(action: { viewModel.reset() }) {
                Text("Reset")
                    .font(.headline)
                    .foregroundStyle(Color.orange)
                    .accessibilityIdentifier("reset-button")
                    .accessibilityLabel("Reset button")
                    .padding()
            }
            
            VStack(spacing: 0) {
                if viewModel.isAtMaximum {
                    Text("Maximum value reached")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.red)
                        .accessibilityIdentifier("max-value-label")
                }
                 
                if viewModel.isAtMinimum {
                    Text("Minimum value reached")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.red)
                        .accessibilityIdentifier("min-value-label")
                }
            }
        }
        .padding()
    }
    
    private func colorForCount() -> Color {
        switch viewModel.count {
        case viewModel.minCount..<viewModel.minCount + 5:
            return .red
        case viewModel.maxCount - 5..<viewModel.maxCount:
            return .green
        default:
            return .primary
        }
    }
}

#Preview {
    ContentView()
}
