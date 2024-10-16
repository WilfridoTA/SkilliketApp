//
//  SimpleWindView.swift
//  Skilliket
//
//  Created by Nicole  on 12/10/24.
//

import SwiftUI
import Charts

struct SimpleWindView: View {
    //La vista cambiara cuando cambie el objeto de abajo
    @ObservedObject var windViewModel: WindViewModel
    var body: some View {
        VStack(alignment: .leading){
            //Revisamos si changedWindStats() devuelve un valor nulo
            if let changedWindStats = changedWindStats(){
                HStack(alignment: .firstTextBaseline){
                    //Mostrar flecha basado en isPositiveChange
                    Image(systemName: isPositiveChange ? "arrow.up.right" : "arrow.down.right").bold()
                    Text("Wind Stats ") +
                    Text(changedWindStats)
                        .bold() +
                    Text(" in the last 30 days.")
                }
            }
            
            Chart(windViewModel.windByWeek, id: \.week){
                BarMark(
                    x: .value("Week", $0.week, unit: .weekOfYear),
                    y: .value("Wind (kmh)", $0.velocity)
                )
            }
            .frame(height: 70)
            .chartYAxis(.hidden)
            .chartXAxis(.hidden)
        }
    }
    
    func changedWindStats() -> String?{
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
        return (Double(windViewModel.totalVelocity) /
                Double(windViewModel.lastTotalVelocity)) - 1
    }
    
    var isPositiveChange: Bool{
        percentage > 0
    }
}

#Preview {
    let increasedVM = WindViewModel.preview
    let decreasedVM = WindViewModel.preview
    decreasedVM.lastTotalVelocity = 24500
    
    return VStack(spacing: 60){
        SimpleWindView(windViewModel: increasedVM)
        SimpleWindView(windViewModel: decreasedVM)
    }
    .padding()
}
