//
//  VariablesViewModel.swift
//  Skilliket
//
//  Created by Nicole  on 16/10/24.
//

import Foundation

class VariablesViewModel: ObservableObject {
    @Published var temperatureData: [TemperatureData?] = []
    @Published var windData: [WindData?] = []
    @Published var waterData: [WaterData?] = []
    @Published var noiseData: [NoiseData?] = []
    
    init(temperatureData: [TemperatureData?], windData: [WindData?], waterData: [WaterData], noiseData: [NoiseData?], skilliketDevice: SkilliketDevice? = nil) {
        self.temperatureData = temperatureData
        self.windData = windData
        self.waterData = waterData
        self.noiseData = noiseData
        self.skilliketDevice = skilliketDevice
    }
    
    
    var skilliketDevice:SkilliketDevice?

    //usar de ejemplo
    func loadDataGDL() {
        skilliketDevice!.fetchTemperatureGDL()
        temperatureData=skilliketDevice!.temperatures
        skilliketDevice!.fetchWindGDL()
        windData=skilliketDevice!.winds
        skilliketDevice!.fetchWaterGDL()
        waterData=skilliketDevice!.water
        skilliketDevice!.fetchNoiseGDL()
        noiseData=skilliketDevice!.noises
    }
    
    func loadDataMTY() {
        skilliketDevice!.fetchTemperatureMTY()
        skilliketDevice!.fetchWindMTY()
        skilliketDevice!.fetchWaterMTY()
        skilliketDevice!.fetchNoiseMTY()
        
        

        temperatureData=skilliketDevice!.temperatures
  
        windData=skilliketDevice!.winds

        waterData=skilliketDevice!.water

        noiseData=skilliketDevice!.noises
    }
    
    func loadDataCDMX() {
        
        temperatureData=skilliketDevice!.temperatures

        windData=skilliketDevice!.winds
        waterData=skilliketDevice!.water
        noiseData=skilliketDevice!.noises
        
        skilliketDevice!.fetchTemperatureCDMX()
        skilliketDevice!.fetchWindCDMX()
        skilliketDevice!.fetchWaterCDMX()
        skilliketDevice!.fetchNoiseCDMX()
    }
    
    func loadDataTRT() {
        

        temperatureData=skilliketDevice!.temperatures

        windData=skilliketDevice!.winds

        waterData=skilliketDevice!.water
        noiseData=skilliketDevice!.noises
        
        skilliketDevice!.fetchTemperatureTRT()
        skilliketDevice!.fetchWindTRT()
        skilliketDevice!.fetchWaterTRT()
        skilliketDevice!.fetchNoiseTRT()
    }

    
}



