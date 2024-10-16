//
//  Wind.swift
//  Jsons
//
//  Created by Astrea Polaris on 09/10/24.
//

import Foundation

class WindData: Data{
    let windLevel:Float
    
    init(date: Date, windLevel:Float) {
        self.windLevel = windLevel
        super.init(date: date)
    }
    
    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let windLevel = try container.decode(Float.self, forKey: .windLevel)
        let date = try container.decode(Date.self, forKey: .date)
        
        self.init(date:date, windLevel: windLevel)
    }
    
    enum CodingKeys: String, CodingKey {
        case windLevel
        case date
    }
    
}

struct WindJSON: Codable {
    let windArray: [WindData]
}
