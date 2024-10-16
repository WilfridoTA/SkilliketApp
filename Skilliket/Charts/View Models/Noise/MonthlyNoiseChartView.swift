//
//  MonthlyNoiseChartView.swift
//  Skilliket
//
//  Created by Nicole  on 15/10/24.
//

import SwiftUI
import Charts

@available(macOS 14.0, *)
struct MonthlyNoiseChartView: View {
    
    @ObservedObject var noiseViewModel: NoiseViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            // Title for the graph
            Text("Monthly Noise Levels (dB)")
                .font(.title2)
                .bold()
                .padding(.bottom, 5)
            
            // Chart displaying monthly noise data
            Chart(noiseViewModel.noiseData) {
                BarMark(
                    x: .value("Month", $0.date, unit: .month),
                    y: .value("Noise Level", $0.noiseLevel)
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
        .padding()
    }
}

@available(macOS 14.0, *)
#Preview {
    VStack {
        MonthlyNoiseChartView(noiseViewModel: .preview)
            .aspectRatio(1, contentMode: .fit)
    }
    .padding()
}

