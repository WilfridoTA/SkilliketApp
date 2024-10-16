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
    
    // Dynamic water data from the view model
    @ObservedObject var viewModel: VariablesViewModel
    
    let numberOfDisplayedDays = 30
    
    @State private var scrollPosition: TimeInterval = TimeInterval()
    
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

    init(viewModel: VariablesViewModel) {
        self.viewModel = viewModel
        
        // Calculate the initial scroll position based on loaded data
        if let lastDateComponents = viewModel.waterData.last?.date {
            let calendar = Calendar.current
            if let lastDate = calendar.date(from: lastDateComponents) {
                // Calculate the beginning of the interval (30 days before the last date)
                let beginningOfInterval = lastDate.addingTimeInterval(-1 * 3600 * 24 * 30)
                self._scrollPosition = State(initialValue: beginningOfInterval.timeIntervalSinceReferenceDate)
            }
        }
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
            Chart(viewModel.waterData, id: \.date) { dataPoint in
                // Convert DateComponents to Date for each data point
                if let date = Calendar.current.date(from: dataPoint.date) {
                    BarMark(
                        x: .value("Day", date, unit: .day),
                        y: .value("Water Level", dataPoint.waterLevel)
                    )
                }
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
        .onAppear {
            // Call loadDataTRT to fetch data when the view appears
            viewModel.loadDataTRT()
        }
        .onChange(of: viewModel.waterData) { newValue in
            // Update the scroll position based on new data
            if let lastDateComponents = newValue.last?.date {
                let calendar = Calendar.current
                if let lastDate = calendar.date(from: lastDateComponents) {
                    let beginningOfInterval = lastDate.addingTimeInterval(-1 * 3600 * 24 * 30)
                    scrollPosition = beginningOfInterval.timeIntervalSinceReferenceDate
                }
            }
        }
    }
}

@available(macOS 14.0, *)
#Preview {
    let viewModel = VariablesViewModel(
        temperatureData: [],
        windData: [],
        waterData: WaterViewModel.preview.waterData,
        noiseData: []
    )
    DailyWaterChartView(viewModel: viewModel)
        .aspectRatio(1, contentMode: .fit)
        .padding()
}







