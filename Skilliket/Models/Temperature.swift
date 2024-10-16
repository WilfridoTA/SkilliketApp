//
//  Temperature.swift
//  Jsons
//
//  Created by Astrea Polaris on 09/10/24.
//

import Foundation

class TemperatureData: Data{
    let temperatureLevel:Float
    
    init(date: Date, temperatureLevel:Float) {
        self.temperatureLevel = temperatureLevel
        super.init(date: date)
    }
    
    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let temperatureLevel = try container.decode(Float.self, forKey: .temperatureLevel)
        let date = try container.decode(Date.self, forKey: .date)
        
        self.init(date:date, temperatureLevel: temperatureLevel)
    }
    
    enum CodingKeys: String, CodingKey {
        case temperatureLevel
        case date
    }
    
}



struct TemperatureJSON: Codable {
    let temperatureArray: [TemperatureData]
}
