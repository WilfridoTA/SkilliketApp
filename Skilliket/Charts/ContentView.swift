//
//  ContentView.swift
//  Skilliket
//
//  Created by Nicole  on 14/10/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var windViewModel: WindViewModel = .preview
    @StateObject var waterViewModel: WaterViewModel = .preview
    @StateObject var noiseViewModel: NoiseViewModel = .preview
    @StateObject var temperatureViewModel: TemperatureViewModel = .preview
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    NavigationLink {
                        DetailWindView(windViewModel: windViewModel)
                            .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        SimpleWindView(windViewModel: windViewModel)
                    }
                }
                
                Section {
                    NavigationLink {
                        DetailWaterView(waterViewModel: waterViewModel)
                            .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        SimpleWaterView(waterViewModel: waterViewModel)
                    }
                }
                
                Section {
                    NavigationLink {
                        DetailNoiseView(noiseViewModel: noiseViewModel)
                            .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        SimpleNoiseView(noiseViewModel: noiseViewModel)
                    }
                }
                Section {
                    NavigationLink {
                        DetailTemperatureView(temperatureViewModel: temperatureViewModel)
                            .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        SimpleTemperatureView(temperatureViewModel: temperatureViewModel)
                    }
                }
            }
            .navigationTitle("General Data View")
        }
    }
}

#Preview {
    ContentView()
}

