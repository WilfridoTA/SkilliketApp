//
//  Temperature.swift
//  Jsons
//
//  Created by Astrea Polaris on 09/10/24.
//

import Foundation

class TemperatureData: Data{
    let celsius:Float
    
    init(date: DateComponents, time: DateComponents,celsius:Float) {
        self.celsius=celsius
        super.init(date: date, time: time)
    }
    
    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let celsius = try container.decode(Float.self, forKey: .celsius)
        let date = try container.decode(DateComponents.self, forKey: .date)
        let time = try container.decode(DateComponents.self, forKey: .time)
        
        self.init(date:date,time:time,celsius: celsius)
    }
    
    enum CodingKeys: String, CodingKey {
        case celsius
        case date
        case time
    }
}
