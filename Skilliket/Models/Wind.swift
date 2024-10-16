//
//  Wind.swift
//  Jsons
//
//  Created by Astrea Polaris on 09/10/24.
//

import Foundation

class WindData: Data{
    let velocity:Float
    
    init(date: DateComponents, time: DateComponents,velocity:Float) {
        self.velocity=velocity
        super.init(date: date, time: time)
    }
    
    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let velocity = try container.decode(Float.self, forKey: .velocity)
        let date = try container.decode(DateComponents.self, forKey: .date)
        let time = try container.decode(DateComponents.self, forKey: .time)
        
        self.init(date:date,time:time,velocity: velocity)
    }
    
    enum CodingKeys: String, CodingKey {
        case velocity
        case date
        case time
    }
}

struct WindJSON: Codable {
    let windArray: [WindData]
}
