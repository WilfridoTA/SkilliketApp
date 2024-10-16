//
//  DetailWaterView.swift
//  Skilliket
//
//  Created by Nicole  on 15/10/24.
//

import SwiftUI
import Charts

struct DetailWaterView: View {
    
    enum TimeInterval: String, CaseIterable, Identifiable {
        case day = "Day"
        case week = "Week"
        case month = "Month"
        var id: Self { self }
    }
    
    @ObservedObject var waterViewModel: WaterViewModel = .preview
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
                Text("Average water level is ") +
                Text("\(String(format: "%.2f", waterViewModel.totalLevel)) m")
                    .bold()
                    .foregroundColor(Color.blue) +
                Text(" over the last 90 days.")
            }
            .padding(.vertical)
            
            Group {
                switch selectedTimeInterval {
                    case .day:
                        if #available(macOS 14.0, *) {
                            DailyWaterChartView(waterData: waterViewModel.waterData)
                        } else {
                            Text("Scrollable charts are only available for macOS 14 and iOS 17.")
                        }
                    case .week:
                        if #available(macOS 14.0, *) {
                            WeeklyWaterChartView(waterViewModel: waterViewModel)
                        } else {
                            Text("Selection in charts is only available for macOS 14 and iOS 17.")
                        }
                    case .month:
                        MonthlyWaterChartView(waterViewModel: waterViewModel)
                }
            }
            .aspectRatio(0.8, contentMode: .fit)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    DetailWaterView(waterViewModel: .preview)
}

