//
//  SimpleNoiseView.swift
//  Skilliket
//
//  Created by Nicole  on 15/10/24.
//

import SwiftUI
import Charts

struct SimpleNoiseView: View {
    // The view will change when the object below changes
    @ObservedObject var noiseViewModel: NoiseViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            // Check if changedNoiseStats() returns a non-nil value
            if let changedNoiseStats = changedNoiseStats() {
                HStack(alignment: .firstTextBaseline) {
                    // Show arrow based on isPositiveChange
                    Image(systemName: isPositiveChange ? "arrow.up.right" : "arrow.down.right").bold()
                    Text("Noise Stats ") +
                    Text(changedNoiseStats)
                        .bold() +
                    Text(" in the last 30 days.")
                }
            }
            
            Chart(noiseViewModel.noiseByWeek, id: \.week) {
                BarMark(
                    x: .value("Week", $0.week, unit: .weekOfYear),
                    y: .value("Noise Level (km/h)", $0.level)
                )
            }
            .frame(height: 70)
            .chartYAxis(.hidden)
            .chartXAxis(.hidden)
        }
    }
    
    func changedNoiseStats() -> String? {
        let percentage = percentage
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        
        guard let formattedPercentage = numberFormatter.string(from: NSNumber(value: percentage)) else {
            return nil
        }
        
        let changedDescription = percentage < 0 ? "decreased by " : "increased by "
        return changedDescription + formattedPercentage
    }
    
    var percentage: Double {
        return (Double(noiseViewModel.totalLevel) /
                Double(noiseViewModel.lastTotalLevel)) - 1
    }
    
    var isPositiveChange: Bool {
        percentage > 0
    }
}

#Preview {
    let increasedVM = NoiseViewModel.preview
    let decreasedVM = NoiseViewModel.preview
    decreasedVM.lastTotalLevel = 24500
    
    return VStack(spacing: 60) {
        SimpleNoiseView(noiseViewModel: increasedVM)
        SimpleNoiseView(noiseViewModel: decreasedVM)
    }
    .padding()
}
