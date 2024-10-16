//
//  MonthlyTemperatureChartView.swift
//  Skilliket
//
//  Created by Nicole  on 15/10/24.
//

import SwiftUI
import Charts


struct MonthlyTemperatureChartView: View {
    @ObservedObject var temperatureViewModel: TemperatureViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Monthly Temperature (°C)") // Title with units for the monthly chart
                .font(.title2)
                .bold()
                .padding(.bottom, 5)
            
            Chart(temperatureViewModel.temperatureData) {
                BarMark(
                    x: .value("Month", $0.date, unit: .month),
                    y: .value("Temperature", $0.celsius)
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
    VStack {
        MonthlyTemperatureChartView(temperatureViewModel: .preview)
            .aspectRatio(1, contentMode: .fit)
            .padding()
    }
}


