//
//  SimpleTemperatureView.swift
//  Skilliket
//
//  Created by Nicole  on 16/10/24.
//

import SwiftUI
import Charts

struct SimpleTemperatureView: View {
    // The view will update when this object changes
    @ObservedObject var temperatureViewModel: TemperatureViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            // Check if changedTemperatureStats() returns a non-nil value
            if let changedTemperatureStats = changedTemperatureStats() {
                HStack(alignment: .firstTextBaseline) {
                    // Show arrow based on isPositiveChange
                    Image(systemName: isPositiveChange ? "arrow.up.right" : "arrow.down.right").bold()
                    Text("Temperature Stats ") +
                    Text(changedTemperatureStats)
                        .bold() +
                    Text(" in the last 30 days.")
                }
            }
            
            Chart(temperatureViewModel.temperatureByWeek, id: \.week) {
                BarMark(
                    x: .value("Week", $0.week, unit: .weekOfYear),
                    y: .value("Temperature (°C)", $0.celsius)
                )
            }
            .frame(height: 70)
            .chartYAxis(.hidden)
            .chartXAxis(.hidden)
        }
    }
    
    func changedTemperatureStats() -> String? {
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
        return (Double(temperatureViewModel.totalCelsius) /
                Double(temperatureViewModel.lastTotalCelsius)) - 1
    }
    
    var isPositiveChange: Bool {
        percentage > 0
    }
}

#Preview {
    let increasedVM = TemperatureViewModel.preview
    let decreasedVM = TemperatureViewModel.preview
    decreasedVM.lastTotalCelsius = 24500
    
    return VStack(spacing: 60) {
        SimpleTemperatureView(temperatureViewModel: increasedVM)
        SimpleTemperatureView(temperatureViewModel: decreasedVM)
    }
    .padding()
}

