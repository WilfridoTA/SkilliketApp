//
//  DetailWindView.swift
//  Skilliket
//
//  Created by Nicole  on 13/10/24.
//

import SwiftUI
import Charts

struct DetailWindView: View {
    
    enum TimeInterval: String, CaseIterable, Identifiable {
        case day = "Day"
        case week = "Week"
        case month = "Month"
        var id: Self { self }
    }
    
    @ObservedObject var windViewModel: WindViewModel = .preview
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
                Text("Average wind velocity is ") +
                Text("\(String(format: "%.2f", windViewModel.totalVelocity)) km/h")
                    .bold()
                    .foregroundColor(Color.blue) +
                Text(" over the last 90 days.")
            }
            .padding(.vertical)
            
            Group {
                switch selectedTimeInterval {
                    case .day:
                        if #available(macOS 14.0, *) {
                            DailyWindChartView(windData: windViewModel.windData)
                        } else {
                            Text("Scrollable charts are only available for macOS 14 and iOS 17.")
                        }
                    case .week:
                        if #available(macOS 14.0, *) {
                            WeeklyWindChartView(windViewModel: windViewModel)
                        } else {
                            Text("Selection in charts is only available for macOS 14 and iOS 17.")
                        }
                    case .month:
                        MonthlyWindChartView(windViewModel: windViewModel)
                }
            }
            .aspectRatio(0.8, contentMode: .fit)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    DetailWindView(windViewModel: .preview)
}

