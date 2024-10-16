//
//  SimpleTemperatureView.swift
//  Skilliket
//
//  Created by Nicole  on 15/10/24.
//

import SwiftUI
import Charts

struct SimpleTemperatureView: View { // Changed from SimpleWindView to SimpleTemperatureView
    @ObservedObject var temperatureViewModel: TemperatureViewModel // Changed from WindViewModel to TemperatureViewModel

    var body: some View {
        VStack(alignment: .leading) {
            if let changedTemperatureStats = changedTemperatureStats() { // Changed from changedWindStats to changedTemperatureStats
                HStack(alignment: .firstTextBaseline) {
                    Image(systemName: isPositiveChange ? "arrow.up.right" : "arrow.down.right").bold()
                    Text("Temperature Stats ") + // Changed from Wind Stats to Temperature Stats
                    Text(changedTemperatureStats) // Changed from changedWindStats to changedTemperatureStats
                        .bold() +
                    Text(" in the last 30 days.")
                }
            }
            
            Chart(temperatureViewModel.tempByWeek, id: \.week) { // Changed from windByWeek to temperatureByWeek
                BarMark(
                    x: .value("Week", $0.week, unit: .weekOfYear),
                    y: .value("Temperature (°C)", $0.temp) // Changed from Wind (kmh) to Temperature (°C)
                )
            }
            .frame(height: 70)
            .chartYAxis(.hidden)
            .chartXAxis(.hidden)
        }
    }
    
    func changedTemperatureStats() -> String? { // Changed from changedWindStats to changedTemperatureStats
        let percentage = temperaturePercentage // Changed from percentage to temperaturePercentage
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        
        guard let formattedPercentage = numberFormatter.string(from: NSNumber(value: percentage)) else {
            return nil
        }
        
        let changedDescription = percentage < 0 ? "decreased by " : "increased by "
        return changedDescription + formattedPercentage
    }
    
    var temperaturePercentage: Double { // Changed from percentage to temperaturePercentage
        return (Double(temperatureViewModel.totalTemp) / // Changed from totalVelocity to totalTemp
                Double(temperatureViewModel.lastTotalTemp)) - 1 // Changed from lastTotalVelocity to lastTotalTemp
    }
    
    var isPositiveChange: Bool {
        temperaturePercentage > 0 // Changed from percentage to temperaturePercentage
    }
}

#Preview {
    let increasedVM = TemperatureViewModel.preview // Changed from WindViewModel to TemperatureViewModel
    let decreasedVM = TemperatureViewModel.preview // Changed from WindViewModel to TemperatureViewModel
    decreasedVM.lastTotalTemp = 24500 // Changed from lastTotalVelocity to lastTotalTemp
    
    return VStack(spacing: 60) {
        SimpleTemperatureView(temperatureViewModel: increasedVM) // Changed from SimpleWindView to SimpleTemperatureView
        SimpleTemperatureView(temperatureViewModel: decreasedVM) // Changed from SimpleWindView to SimpleTemperatureView
    }
    .padding()
}

