//
//  WeeklyTemperatureChartView.swift
//  Skilliket
//
//  Created by Nicole  on 15/10/24.
//

import SwiftUI
import Charts

@available(macOS 14.0, iOS 17, *)
struct WeeklyTemperatureChartView: View {
    
    @ObservedObject var temperatureViewModel: TemperatureViewModel
    @State private var rawSelectedDate: Date? = nil
    
    @Environment(\.calendar) var calendar

    var selectedDateValue: (week: Date, temp: Float)? {
        if let rawSelectedDate {
            return temperatureViewModel.tempByWeek.first(where: {
                let startOfWeek = $0.week
                let endOfWeek = endOfWeek(for: startOfWeek) ?? Date()
                return (startOfWeek ... endOfWeek).contains(rawSelectedDate)
            })
        }
        return nil
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            // Title with units
            Text("Weekly Temperature (°C)")
                .font(.title2)
                .bold()
                .padding(.bottom, 5)

            Chart(temperatureViewModel.tempByWeek, id: \.week) {
                BarMark(
                    x: .value("Week", $0.week, unit: .weekOfYear),
                    y: .value("Temperature", $0.temp)
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
                Text("\(String(format: "%.2f", selectedDateValue.temp)) °C") // Updated to show temperature unit (°C)
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
    WeeklyTemperatureChartView(temperatureViewModel: .preview)
        .aspectRatio(1, contentMode: .fit)
        .padding()
}

