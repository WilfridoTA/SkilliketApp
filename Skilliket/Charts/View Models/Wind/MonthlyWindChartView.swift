//
//  MonthlyWindChartView.swift
//  Skilliket
//
//  Created by Nicole  on 13/10/24.
//

import SwiftUI
import Charts


struct MonthlyWindChartView: View {
    
    @ObservedObject var windViewModel: WindViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            
            // Title for the chart
            Text("Monthly Wind Velocities (m/s)")
                .font(.title2)
                .bold()
                .padding(.bottom, 5)
            
            Chart(windViewModel.windData) {
                BarMark(
                    x: .value("Month", $0.date, unit: .month),
                    y: .value("Wind Velocity", $0.velocity)
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
        MonthlyWindChartView(windViewModel: .preview)
            .aspectRatio(1, contentMode: .fit)
    }
    .padding()
}


