//
//  Noise.swift
//  Jsons
//
//  Created by Astrea Polaris on 09/10/24.
//

import Foundation

class NoiseData: Data{
    let noiseLevel:Float
    
    init(date: DateComponents, time: DateComponents,noiseLevel:Float) {
        self.noiseLevel=noiseLevel
        super.init(date: date, time: time)
    }
    
    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let noiseLevel = try container.decode(Float.self, forKey: .noiseLevel)
        let date = try container.decode(DateComponents.self, forKey: .date)
        let time = try container.decode(DateComponents.self, forKey: .time)
        
        self.init(date:date,time:time,noiseLevel:noiseLevel)
    }
    
    enum CodingKeys: String, CodingKey {
        case noiseLevel
        case date
        case time
    }
    
}
