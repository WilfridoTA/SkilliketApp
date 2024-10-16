//
//  SimpleWaterView.swift
//  Skilliket
//
//  Created by Nicole  on 15/10/24.
//

import SwiftUI
import Charts

struct SimpleWaterView: View {
    // La vista cambiará cuando cambie el objeto de abajo
    @ObservedObject var waterViewModel: WaterViewModel
    var body: some View {
        VStack(alignment: .leading){
            // Revisamos si changedWaterStats() devuelve un valor nulo
            if let changedWaterStats = changedWaterStats(){
                HStack(alignment: .firstTextBaseline){
                    // Mostrar flecha basada en isPositiveChange
                    Image(systemName: isPositiveChange ? "arrow.up.right" : "arrow.down.right").bold()
                    Text("Water Stats ") +
                    Text(changedWaterStats)
                        .bold() +
                    Text(" in the last 30 days.")
                }
            }
            
            Chart(waterViewModel.waterByWeek, id: \.week){
                BarMark(
                    x: .value("Week", $0.week, unit: .weekOfYear),
                    y: .value("Water (m)", $0.level)
                )
            }
            .frame(height: 70)
            .chartYAxis(.hidden)
            .chartXAxis(.hidden)
        }
    }
    
    func changedWaterStats() -> String? {
        let percentage = percentage
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        
        guard let formattedPercentage = numberFormatter.string(from: NSNumber(value: percentage)) else {
            return nil
        }
        
        let changedDescription = percentage < 0 ? "decreased by " : "increased by "
        return changedDescription + formattedPercentage
    }
    
    var percentage: Double {
        return (Double(waterViewModel.totalLevel) /
                Double(waterViewModel.lastTotalLevel)) - 1
    }
    
    var isPositiveChange: Bool {
        percentage > 0
    }
}

#Preview {
    let increasedVM = WaterViewModel.preview
    let decreasedVM = WaterViewModel.preview
    decreasedVM.lastTotalLevel = 24500
    
    return VStack(spacing: 60){
        SimpleWaterView(waterViewModel: increasedVM)
        SimpleWaterView(waterViewModel: decreasedVM)
    }
    .padding()
}

