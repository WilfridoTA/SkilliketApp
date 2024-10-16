//
//  Noise.swift
//  Jsons
//
//  Created by Astrea Polaris on 09/10/24.
//

import Foundation

class NoiseData: Data{
    let noiseLevel:Float
    
    init(date: Date, noiseLevel:Float) {
        self.noiseLevel=noiseLevel
        super.init(date: date)
    }
    
    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let noiseLevel = try container.decode(Float.self, forKey: .noiseLevel)
        let date = try container.decode(Date.self, forKey: .date)
        
        self.init(date:date, noiseLevel:noiseLevel)
    }
    
    enum CodingKeys: String, CodingKey {
        case noiseLevel
        case date
    }
    
}

struct NoiseJSON: Codable {
    let noiseArray: [NoiseData]
}
