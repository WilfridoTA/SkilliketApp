//
//  MonthlyWaterChartView.swift
//  Skilliket
//
//  Created by Nicole  on 15/10/24.
//

import SwiftUI
import Charts


struct MonthlyWaterChartView: View {
    
    @ObservedObject var waterViewModel: WaterViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            
            // Title for the chart
            Text("Monthly Water Levels (cm)")
                .font(.title2)
                .bold()
                .padding(.bottom, 5)
            
            // The chart displaying monthly water level data
            Chart(waterViewModel.waterData) {
                BarMark(
                    x: .value("Month", $0.date, unit: .month),
                    y: .value("Water Level", $0.waterLevel)
                )
                .foregroundStyle(.blue)
            }
            .chartXAxis {
                AxisMarks(values: .stride(by: .month)) { _ in
                    AxisGridLine()
                    AxisTick()
                    AxisValueLabel(format: .dateTime.month(.abbreviated), centered: true)
                }
            }
        }
    }
}

#Preview {
    VStack{
        MonthlyWaterChartView(waterViewModel: .preview)
            .aspectRatio(1, contentMode: .fit)
        
    }
    .padding()
}

