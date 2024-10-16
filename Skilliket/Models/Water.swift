//
//  Humidity.swift
//  Jsons
//
//  Created by Astrea Polaris on 09/10/24.
//

import Foundation

class WaterData: Data, Identifiable, Equatable {
    let waterLevel: Float
    
    // Add a property to uniquely identify each instance
    // For example, using an id or combining date and time properties
    var id: UUID // Add a unique identifier for each instance

    init(date: DateComponents, time: DateComponents, waterLevel: Float) {
        self.waterLevel = waterLevel
        self.id = UUID() // Generate a unique identifier
        super.init(date: date, time: time)
    }

    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let waterLevel = try container.decode(Float.self, forKey: .waterLevel)
        let date = try container.decode(DateComponents.self, forKey: .date)
        let time = try container.decode(DateComponents.self, forKey: .time)
        
        self.init(date: date, time: time, waterLevel: waterLevel)
    }
    
    // Implementing Equatable protocol
    static func == (lhs: WaterData, rhs: WaterData) -> Bool {
        // Compare properties that define equality
        return lhs.waterLevel == rhs.waterLevel &&
               lhs.date == rhs.date && // Assuming date is accessible
               lhs.time == rhs.time &&   // Assuming time is accessible
               lhs.id == rhs.id          // Ensure unique identifiers are equal (if applicable)
    }
    
    enum CodingKeys: String, CodingKey {
        case waterLevel
        case date
        case time
    }
}

struct WaterJSON: Codable {
    let waterArray: [WaterData]
}
