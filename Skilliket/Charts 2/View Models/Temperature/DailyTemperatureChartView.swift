//
//  DailyTemperatureChartView.swift
//  Skilliket
//
//  Created by Nicole  on 16/10/24.
//

import SwiftUI
import Charts

@available(macOS 14.0, *)
struct DailyTemperatureChartView: View {
    
    let temperatureData: [TemperatureData2]
      
    init(temperatureData: [TemperatureData2]) {
        self.temperatureData = temperatureData
          
        guard let lastDate = temperatureData.last?.date else { return }
        let beginningOfInterval = lastDate.addingTimeInterval(-1 * 3600 * 24 * 30)
          
        self._scrollPosition = State(initialValue: beginningOfInterval.timeIntervalSinceReferenceDate)
    }
    
    let numberOfDisplayedDays = 30
    
    @State var scrollPosition: TimeInterval = TimeInterval()
    
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
            
            // Title for the chart
            Text("Daily Temperatures (°C)")
                .font(.title2)
                .bold()
                .padding(.bottom, 5)
            
            Text("\(scrollPositionStartString) – \(scrollPositionEndString)")
                .font(.callout)
                .foregroundStyle(.secondary)
            
            Chart(temperatureData, id: \.date) {
                BarMark(
                    x: .value("Day", $0.date, unit: .day),
                    y: .value("Temperature", $0.celsius)
                )
            }
            .chartScrollableAxes(.horizontal)
            .chartXVisibleDomain(length: 3600 * 24 * numberOfDisplayedDays) // shows 30 days
            // snap to beginning of the month when scrolling ends
            .chartScrollTargetBehavior(
                .valueAligned(
                    matching: .init(hour: 0),
                    majorAlignment: .matching(.init(day: 1))))
            .chartScrollPosition(x: $scrollPosition)
        }
    }
}

@available(macOS 14.0, *)
#Preview {
    DailyTemperatureChartView(temperatureData: TemperatureViewModel.preview.temperatureData)
        .aspectRatio(1, contentMode: .fit)
        .padding()
}

