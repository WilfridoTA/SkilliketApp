//
//  DailyWaterChartView.swift
//  Skilliket
//
//  Created by Nicole  on 15/10/24.
//

import SwiftUI
import Charts

@available(macOS 14.0, *)
struct DailyWaterChartView: View {
    
    let waterData: [WaterData]
      
    init(waterData: [WaterData]) {
        self.waterData = waterData
          
        guard let lastDate = waterData.last?.date else { return }
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
            Text("Daily Water Levels (cm)")
                .font(.title2)
                .bold()
                .padding(.bottom, 5)
            
            // Display date range of the chart
            Text("\(scrollPositionStartString) – \(scrollPositionEndString)")
                .font(.callout)
                .foregroundStyle(.secondary)
            
            // The chart displaying daily water level data
            Chart(waterData, id: \.date) {
                BarMark(
                    x: .value("Day", $0.date, unit: .day),
                    y: .value("Water Level", $0.waterLevel)
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
    DailyWaterChartView(waterData: WaterViewModel.preview.waterData)
        .aspectRatio(1, contentMode: .fit)
        .padding()
}

