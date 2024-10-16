//
//  WeeklyWaterChartView.swift
//  Skilliket
//
//  Created by Nicole  on 15/10/24.
//

import SwiftUI
import Charts

@available(macOS 14.0, iOS 17, *)
struct WeeklyWaterChartView: View {
    
    @ObservedObject var waterViewModel: WaterViewModel
    @State private var rawSelectedDate: Date? = nil
    
    @Environment(\.calendar) var calendar

    var selectedDateValue: (week: Date, level: Float)? {
        if let rawSelectedDate {
            return waterViewModel.waterByWeek.first(where: {
                let startOfWeek = $0.week
                let endOfWeek = endOfWeek(for: startOfWeek) ?? Date()
                return (startOfWeek ... endOfWeek).contains(rawSelectedDate)
            })
        }
        return nil
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            // Title for the chart
            Text("Weekly Water Levels (cm)")
                .font(.title2)
                .bold()
                .padding(.bottom, 5)
            
            // The chart displaying weekly water level data
            Chart(waterViewModel.waterByWeek, id: \.week) {
                BarMark(
                    x: .value("Week", $0.week, unit: .weekOfYear),
                    y: .value("Water Level", $0.level)
                )
                .opacity(selectedDateValue == nil || $0.week == selectedDateValue?.week ? 1 : 0.5)
                
                if let rawSelectedDate {
                    RuleMark(x: .value("Selected", rawSelectedDate, unit: .day))
                        .foregroundStyle(Color.gray.opacity(0.3))
                        .offset(yStart: -10)
                        .zIndex(-1)
                        .annotation(
                            position: .top,
                            spacing: 0,
                            overflowResolution: .init(
                                x: .fit(to: .chart),
                                y: .disabled
                            )
                        ) {
                            selectionPopover
                        }
                }
            }
            .chartXSelection(value: $rawSelectedDate)
        }
    }
    
    func endOfWeek(for startOfWeek: Date) -> Date? {
        calendar.date(byAdding: .day, value: 6, to: startOfWeek)
    }
    
    @ViewBuilder
    var selectionPopover: some View {
        if let rawSelectedDate, let selectedDateValue {
            VStack {
                Text(selectedDateValue.week.formatted(Date.FormatStyle().month().day()))
                Text("\(String(format: "%.2f", selectedDateValue.level)) cm")
                    .bold()
                    .foregroundStyle(.blue)
            }
            .padding(6)
            .background {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.white)
                    .shadow(color: .blue, radius: 2)
            }
        }
    }
}

@available(macOS 14.0, iOS 17, *)
#Preview {
    WeeklyWaterChartView(waterViewModel: .preview)
        .aspectRatio(1, contentMode: .fit)
        .padding()
}

