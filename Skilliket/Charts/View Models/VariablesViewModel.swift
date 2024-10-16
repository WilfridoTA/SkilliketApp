//
//  VariablesViewModel.swift
//  Skilliket
//
//  Created by Nicole  on 16/10/24.
//

import Foundation

class VariablesViewModel: ObservableObject {
    @Published var temperatureData: [TemperatureData] = []
    @Published var windData: [WindData] = []
    @Published var waterData: [WaterData] = []
    @Published var noiseData: [NoiseData] = []
    
    init(temperatureData: [TemperatureData], windData: [WindData], waterData: [WaterData], noiseData: [NoiseData], skilliketDevice: SkilliketDevice? = nil) {
        self.temperatureData = temperatureData
        self.windData = windData
        self.waterData = waterData
        self.noiseData = noiseData
        self.skilliketDevice = skilliketDevice
    }
    
    
    var skilliketDevice:SkilliketDevice?

    func loadData() {
        skilliketDevice!.fetchTemperatureMTY()
        fetchWindMTY()
        fetchWaterMTY()
        fetchNoiseMTY()
        
        fetchTemperatureGDL()
        fetchWindGDL()
        fetchWaterGDL()
        fetchNoiseGDL()
        
        fetchTemperatureCDMX()
        fetchWindCDMX()
        fetchWaterCDMX()
        fetchNoiseCDMX()
        
        fetchTemperatureTRT()
        fetchWindTRT()
        fetchWaterTRT()
        fetchNoiseTRT()
    }

    
}



