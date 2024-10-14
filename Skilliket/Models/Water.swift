//
//  Humidity.swift
//  Jsons
//
//  Created by Astrea Polaris on 09/10/24.
//

import Foundation

class WaterData: Data{
    let waterLevel:Float
    
    init(date: DateComponents, time: DateComponents,waterLevel:Float) {
        self.waterLevel=waterLevel
        super.init(date: date, time: time)
    }
    
    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let waterLevel = try container.decode(Float.self, forKey: .waterLevel)
        let date = try container.decode(DateComponents.self, forKey: .date)
        let time = try container.decode(DateComponents.self, forKey: .time)
        
        self.init(date:date,time:time,waterLevel: waterLevel)
    }
    
    enum CodingKeys: String, CodingKey {
        case waterLevel
        case date
        case time
    }
}
