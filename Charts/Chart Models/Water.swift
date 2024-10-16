//
//  Water.swift
//  Skilliket
//
//  Created by Nicole  on 15/10/24.
//

import Foundation

struct WaterData: Identifiable, Equatable, Codable {
    let id: UUID
    let waterLevel: Float
    
    let date: Date
    let time: Date
    
    /*
     // Example instance for demonstration purposes
     static var example = WaterData(
     id: UUID(),
     waterLevel: 1.5,
     velocity: 5.0,
     
     
     noiseLevel: 50.0,
     celsius: 22.0,
     date: Date(),
     time: Date()
     )
     
     // Array of example instances
     static var examples: [WaterData] = [
     WaterData(id: UUID(), waterLevel: 1.2, velocity: 4.5, noiseLevel: 48.0, celsius: 20.0, date: Date(timeIntervalSinceNow: -7_200_000), time: Date()),
     WaterData(id: UUID(), waterLevel: 1.8, velocity: 5.2, noiseLevel: 52.0, celsius: 21.0, date: Date(timeIntervalSinceNow: -14_400_000), time: Date()),
     WaterData(id: UUID(), waterLevel: 2.0, velocity: 5.8, noiseLevel: 55.0, celsius: 22.5, date: Date(timeIntervalSinceNow: -21_600_000), time: Date()),
     WaterData(id: UUID(), waterLevel: 0.9, velocity: 3.5, noiseLevel: 47.0, celsius: 19.5, date: Date(timeIntervalSinceNow: -28_800_000), time: Date()),
     WaterData(id: UUID(), waterLevel: 1.6, velocity: 6.0, noiseLevel: 49.0, celsius: 23.0, date: Date(timeIntervalSinceNow: -36_000_000), time: Date())
     ]
     
     // Generates water level data for the last three months
     static func threeMonthsExamples() -> [WaterData] {
     let threeMonthsAgo = Calendar.current.date(byAdding: .month, value: -3, to: Date())!
     
     let exampleWaterData: [WaterData] = (1...300).map { _ in
     let randomWaterLevel = Float.random(in: 0.5...2.5)
     let randomVelocity = Float.random(in: 0...10) // Example range for velocity
     let randomNoiseLevel = Float.random(in: 40...70) // Example range for noise level
     let randomCelsius = Float.random(in: 15...30) // Example range for temperature
     let randomDate = Date.random(in: threeMonthsAgo...Date())
     
     return WaterData(
     id: UUID(),
     waterLevel: randomWaterLevel,
     velocity: randomVelocity,
     noiseLevel: randomNoiseLevel,
     celsius: randomCelsius,
     date: randomDate,
     time: randomDate
     )
     }
     return exampleWaterData.sorted { $0.date < $1.date }
     }
     
     // Generates weekend data with higher water levels
     static var higherWeekendThreeMonthsExamples: [WaterData] = {
     let threeMonthsAgo = Calendar.current.date(byAdding: .month, value: -3, to: Date())!
     let exampleWaterData: [WaterData] = (1...300).map { _ in
     let randomDate = Date.random(in: threeMonthsAgo...Date())
     let weekday = Calendar.current.component(.weekday, from: randomDate)
     
     // Higher water levels on weekends
     let averageWaterLevel: Float = (weekday == 7 || weekday == 1) ? 2.0 : 1.0
     let randomWaterLevel = Float.random(in: averageWaterLevel - 0.5...averageWaterLevel + 0.5)
     
     // Random values for other properties
     let randomVelocity = Float.random(in: 0...10) // Example range for velocity
     let randomNoiseLevel = Float.random(in: 40...70) // Example range for noise level
     let randomCelsius = Float.random(in: 15...30) // Example range for temperature
     
     return WaterData(
     id: UUID(),
     waterLevel: randomWaterLevel,
     velocity: randomVelocity,
     noiseLevel: randomNoiseLevel,
     celsius: randomCelsius,
     date: randomDate,
     time: randomDate
     )
     }
     return exampleWaterData.sorted { $0.date < $1.date }
     }()
     
     }
     
     
     */
    
}
class WaterJSON: Codable {
    let waterArray: [WaterData]

    init(waterArray: [WaterData]) {
        self.waterArray = waterArray
    }

    // Manual Decodable conformance
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.waterArray = try container.decode([WaterData].self, forKey: .waterArray)
    }

    // Manual Encodable conformance (optional, if you also want to encode)
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(waterArray, forKey: .waterArray)
    }

    private enum CodingKeys: String, CodingKey {
        case waterArray
    }
}

/*

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

*/
