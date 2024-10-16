//
//  DailyTemperatureChartView.swift
//  Skilliket
//
//  Created by Nicole  on 15/10/24.
//

import SwiftUI
import Charts

@available(macOS 14.0, *)
struct DailyTemperatureChartView: View {
    
    let temperatureData: [TemperatureData]
    
    init(temperatureData: [TemperatureData]) {
        self.temperatureData = temperatureData
        
        guard let lastDate = temperatureData.last?.date else { return }
        let beginningOfInterval = lastDate.addingTimeInterval(-1 * 3600 * 24 * 30)
        
        self._scrollPosition = State(initialValue: beginningOfInterval.timeIntervalSinceReferenceDate)
    }
    
    let numberOfDisplayedDays = 30
    
    @State var scrollPosition: TimeInterval = TimeInterval()
    @State private var showWaterLevel: Bool = false // Toggle for water level
    @State private var showNoiseLevel: Bool = false // Toggle for noise level
    @State private var showWindVelocity: Bool = false // Toggle for wind velocity
    
    var scrollPositionStart: Date {
        Date(timeIntervalSinceReferenceDate: scrollPosition)
    }
    
    var scrollPositionEnd: Date {
        scrollPositionStart.addingTimeInterval(3600 * 24 * 30)
    }
    
    var scrollPositionStartString: String {
        scrollPositionStart.formatted(.dateTime.month().day())
    }
    
    var scrollPositionEndString: String {
        scrollPositionEnd.formatted(.dateTime.month().day().year())
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            
            // Title of the chart
            Text("Daily Temperature (Cº)")
                .font(.title2)
                .bold()
                .padding(.bottom, 10)
            
            // Toggle to show or hide the water level
            Toggle(isOn: $showWaterLevel) {
                Text("Show Water Level")
            }
            .padding(.bottom, 5)
            
            // Toggle to show or hide noise level
            Toggle(isOn: $showNoiseLevel) {
                Text("Show Noise Level")
            }
            .padding(.bottom, 5)
            
            // Toggle to show or hide wind velocity
            Toggle(isOn: $showWindVelocity) {
                Text("Show Wind Velocity")
            }
            .padding(.bottom, 10)
            
            // Display the date range
            Text("\(scrollPositionStartString) – \(scrollPositionEndString)")
                .font(.callout)
                .foregroundStyle(.secondary)
            
            // Manual legend for the colors
            HStack {
                if showWaterLevel || showNoiseLevel || showWindVelocity {
                    Label("Temperature", systemImage: "circle.fill")
                        .foregroundStyle(.blue)
                    if showWaterLevel {
                        Label("Water Level", systemImage: "triangle.fill")
                            .foregroundStyle(.green)
                    }
                    if showNoiseLevel {
                        Label("Noise Level", systemImage: "square.fill")
                            .foregroundStyle(.orange)
                    }
                    if showWindVelocity {
                        Label("Wind Velocity", systemImage: "diamond.fill")
                            .foregroundStyle(.purple)
                    }
                }
            }
            .padding(.bottom, 10)
            
            // Graph temperature as a bar chart when showing temperature alone
            if !showWaterLevel && !showNoiseLevel && !showWindVelocity {
                Chart {
                    ForEach(temperatureData) { data in
                        BarMark(
                            x: .value("Day", data.date, unit: .day),
                            y: .value("Temperature", data.celsius)
                        )
                        .foregroundStyle(.blue)
                    }
                }
                .chartScrollableAxes(.horizontal)
                .chartXVisibleDomain(length: 3600 * 24 * numberOfDisplayedDays) // shows 30 days
                .chartScrollPosition(x: $scrollPosition)
                .chartXAxisLabel("Date") // X-axis label
                .chartYAxisLabel("Temperature (°C)") // Y-axis label
            } else {
                // Graph temperature and selected variables as line charts when showing multiple variables
                Chart {
                    // Line for temperature
                    ForEach(temperatureData) { data in
                        LineMark(
                            x: .value("Day", data.date, unit: .day),
                            y: .value("Temperature", data.celsius)
                        )
                        .foregroundStyle(.blue) // Color for temperature
                        .symbol(.circle)
                    }
                    
                    // Line for water level if toggle is on
                    if showWaterLevel {
                        ForEach(temperatureData) { data in
                            LineMark(
                                x: .value("Day", data.date, unit: .day),
                                y: .value("Water Level", data.waterLevel)
                            )
                            .foregroundStyle(.green) // Color for water level
                            .symbol(.triangle)
                        }
                    }
                    
                    // Line for noise level if toggle is on
                    if showNoiseLevel {
                        ForEach(temperatureData) { data in
                            LineMark(
                                x: .value("Day", data.date, unit: .day),
                                y: .value("Noise Level", data.noiseLevel)
                            )
                            .foregroundStyle(.orange) // Color for noise level
                            .symbol(.square)
                        }
                    }
                    
                    // Line for wind velocity if toggle is on
                    if showWindVelocity {
                        ForEach(temperatureData) { data in
                            LineMark(
                                x: .value("Day", data.date, unit: .day),
                                y: .value("Wind Velocity", data.velocity)
                            )
                            .foregroundStyle(.purple) // Color for wind velocity
                            .symbol(.diamond)
                        }
                    }
                }
                .chartScrollableAxes(.horizontal)
                .chartXVisibleDomain(length: 3600 * 24 * numberOfDisplayedDays) // shows 30 days
                // Snap to beginning of the month when scrolling ends
                .chartScrollTargetBehavior(
                    .valueAligned(
                        matching: .init(hour: 0),
                        majorAlignment: .matching(.init(day: 1))))
                .chartScrollPosition(x: $scrollPosition)
                .chartXAxisLabel("Date") // X-axis label
                .chartYAxisLabel("Value") // Y-axis label (for multiple variables)
            }
        }
    }
}

@available(macOS 14.0, *)
#Preview {
    DailyTemperatureChartView(temperatureData: TemperatureViewModel.preview.temperatureData) // Use TemperatureViewModel.preview
        .aspectRatio(1, contentMode: .fit)
        .padding()
}
