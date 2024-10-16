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

    init(date: Date, waterLevel: Float) {
        self.waterLevel = waterLevel
        self.id = UUID() // Generate a unique identifier
        super.init(date: date)
    }

    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let waterLevel = try container.decode(Float.self, forKey: .waterLevel)
        let date = try container.decode(Date.self, forKey: .date)
        
        self.init(date: date, waterLevel: waterLevel)
    }
    
    // Implementing Equatable protocol
    static func == (lhs: WaterData, rhs: WaterData) -> Bool {
        // Compare properties that define equality
        return lhs.waterLevel == rhs.waterLevel &&
               lhs.date == rhs.date && // Assuming date is accessible
               lhs.id == rhs.id          // Ensure unique identifiers are equal (if applicable)
    }
    
    enum CodingKeys: String, CodingKey {
        case waterLevel
        case date
    }
}

struct WaterJSON: Codable {
    let waterArray: [WaterData]
}
