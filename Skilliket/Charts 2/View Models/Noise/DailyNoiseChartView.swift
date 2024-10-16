//
//  DailyNoiseChartView.swift
//  Skilliket
//
//  Created by Nicole  on 15/10/24.
//

import SwiftUI
import Charts

@available(macOS 14.0, *)
struct DailyNoiseChartView: View {
    
    let noiseData: [NoiseData2]
    
    init(noiseData: [NoiseData2]) {
        self.noiseData = noiseData
        
        guard let lastDate = noiseData.last?.date else { return }
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
            // Title for the graph
            Text("Daily Noise Levels (dB)") // Title indicating noise levels
                .font(.title2)
                .bold()
                .padding(.bottom, 5)

            // Date range display
            Text("\(scrollPositionStartString) – \(scrollPositionEndString)")
                .font(.callout)
                .foregroundStyle(.secondary)
            
            // Chart displaying noise data
            Chart(noiseData, id: \.date) {
                BarMark(
                    x: .value("Day", $0.date, unit: .day),
                    y: .value("Noise Level", $0.noiseLevel)
                )
            }
            .chartScrollableAxes(.horizontal)
            .chartXVisibleDomain(length: 3600 * 24 * numberOfDisplayedDays) // shows 30 days
            .chartScrollTargetBehavior(
                .valueAligned(
                    matching: .init(hour: 0),
                    majorAlignment: .matching(.init(day: 1))))
            .chartScrollPosition(x: $scrollPosition)
        }
        .padding() // Add some padding to the VStack
    }
}

@available(macOS 14.0, *)
#Preview {
    DailyNoiseChartView(noiseData: NoiseViewModel.preview.noiseData)
        .aspectRatio(1, contentMode: .fit)
        .padding()
}

