//
//  SkilliketDevice.swift
//  Jsons
//
//  Created by Astrea Polaris on 07/10/24.
//

import Foundation

class SkilliketDevice: Codable {
    let id: Int
    let name: String
    let location: String
    let status: StatusDevice
    var temperatures: [TemperatureData?]
    var winds:[WindData?]
    var noises:[NoiseData?]
    var water:[WaterData?]

    init(id: Int, name: String, location: String, status: StatusDevice) {
        self.id = id
        self.name = name
        self.location = location
        self.status = status
        self.temperatures=[]
        self.winds=[]
        self.noises=[]
        self.water=[]
    }
}

enum StatusDevice: Codable{
    case up
    case down
}
