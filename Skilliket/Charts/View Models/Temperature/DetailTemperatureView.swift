//
//  DetailTemperatureView.swift
//  Skilliket
//
//  Created by Nicole  on 15/10/24.
//

import SwiftUI
import Charts

struct DetailTemperatureView: View {
    
    enum TimeInterval: String, CaseIterable, Identifiable {
        case day = "Day"
        case week = "Week"
        case month = "Month"
        var id: Self { self }
    }
    
    @ObservedObject var temperatureViewModel: TemperatureViewModel = .preview // Changed from WindViewModel to TemperatureViewModel
    @State private var selectedTimeInterval = TimeInterval.day
    
    var body: some View {
        VStack(alignment: .leading) {
            Picker(selection: $selectedTimeInterval.animation()) {
                ForEach(TimeInterval.allCases) { interval in
                    Text(interval.rawValue)
                }
            } label: {
                Text("Time interval")
            }
            .pickerStyle(.segmented)
            
            Group {
                Text("Average temperature is ") + // Changed "wind velocity" to "temperature"
                Text("\(String(format: "%.2f", temperatureViewModel.totalTemp)) °C") // Changed "km/h" to "°C" and adjusted to use totalTemperature
                    .bold()
                    .foregroundColor(Color.blue) +
                Text(" over the last 90 days.")
            }
            .padding(.vertical)
            
            Group {
                switch selectedTimeInterval {
                    case .day:
                        if #available(macOS 14.0, *) {
                            DailyTemperatureChartView(temperatureData: temperatureViewModel.temperatureData) // Changed to use DailyTemperatureChartView
                        } else {
                            Text("Scrollable charts are only available for macOS 14 and iOS 17.")
                        }
                    case .week:
                        if #available(macOS 14.0, *) {
                            WeeklyTemperatureChartView(temperatureViewModel: temperatureViewModel) // Changed to use WeeklyTemperatureChartView
                        } else {
                            Text("Selection in charts is only available for macOS 14 and iOS 17.")
                        }
                    case .month:
                        MonthlyTemperatureChartView(temperatureViewModel: temperatureViewModel) // Changed to use MonthlyTemperatureChartView
                }
            }
            .aspectRatio(0.8, contentMode: .fit)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    DetailTemperatureView(temperatureViewModel: .preview) // Changed to DetailTemperatureView
}

