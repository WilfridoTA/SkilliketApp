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

    func loadDataGDL() {
        skilliketDevice!.fetchTemperatureGDL()
        skilliketDevice!.fetchWindGDL()
        skilliketDevice!.fetchWaterGDL()
        skilliketDevice!.fetchNoiseGDL()
    }
    
    func loadDataMTY() {
        skilliketDevice!.fetchTemperatureMTY()
        skilliketDevice!.fetchWindMTY()
        skilliketDevice!.fetchWaterMTY()
        skilliketDevice!.fetchNoiseMTY()
    }
    
    func loadDataCDMX() {
        skilliketDevice!.fetchTemperatureCDMX()
        skilliketDevice!.fetchWindCDMX()
        skilliketDevice!.fetchWaterCDMX()
        skilliketDevice!.fetchNoiseCDMX()
    }
    
    func loadDataTRT() {
        skilliketDevice!.fetchTemperatureTRT()
        skilliketDevice!.fetchWindTRT()
        skilliketDevice!.fetchWaterTRT()
       // waterData = SkilliketDevice.water
        skilliketDevice!.fetchNoiseTRT()
    }

    
}



