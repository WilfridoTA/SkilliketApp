//
//  MacContentView.swift
//  Skilliket
//
//  Created by Nicole  on 12/10/24.
//

import SwiftUI

struct MacContentView: View {
    
    enum NavigationSelection{
        case windStats
        case waterStats
        case noiseStats
        case temperatureStats
    }
    
    @StateObject var windViewModel: WindViewModel = .preview
    @StateObject var waterViewModel: WaterViewModel = .preview
    @StateObject var noiseViewModel: NoiseViewModel = .preview
    @StateObject var temperatureViewModel: TemperatureViewModel = .preview
    
    @State private var navigationSelection: NavigationSelection? = .windStats
    var body: some View {
        NavigationSplitView{
            List(selection: $navigationSelection){
                Group{
                    SimpleWindView(windViewModel: windViewModel)
                        .tag(NavigationSelection.windStats)
                }
                Group{
                    SimpleWaterView(waterViewModel: waterViewModel)
                        .tag(NavigationSelection.waterStats)
                }
                Group{
                    SimpleNoiseView(noiseViewModel: noiseViewModel)
                        .tag(NavigationSelection.noiseStats)
                }
                Group{
                    SimpleTemperatureView(temperatureViewModel: temperatureViewModel)
                        .tag(NavigationSelection.temperatureStats)
                }
                .listRowInsets(.init(top: 10, leading: 10, bottom: 50, trailing: 10))
            }
        } detail: {
            switch navigationSelection {
            case .windStats:
                DetailWindView(windViewModel: windViewModel)
            case .waterStats:
                DetailWaterView(waterViewModel: waterViewModel)
            case .noiseStats:
                DetailNoiseView(noiseViewModel: noiseViewModel)
            case .temperatureStats:
                DetailTemperatureView(temperatureViewModel: temperatureViewModel)
            default:
                Text("Plaecholder")
            }
        }
    }
}

#Preview {
    MacContentView()
}
