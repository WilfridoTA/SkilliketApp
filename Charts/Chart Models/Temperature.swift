//
//  Temperature.swift
//  Skilliket
//
//  Created by Nicole  on 15/10/24.
//

import Foundation
struct TemperatureData: Identifiable, Equatable, Codable {
    let id: UUID
    let celsius: Float
    let waterLevel: Float
    let velocity: Float
    let noiseLevel: Float
    
    let date: Date
    let time: Date
    /*
     // Example instance
     static var example = TemperatureData(
     id: UUID(),
     celsius: 22.0,
     waterLevel: 1.7,
     velocity: 5.0,
     noiseLevel: 50.0,
     date: Date(),
     time: Date()
     )
     
     // Array of example instances
     static var examples: [TemperatureData] = [
     TemperatureData(id: UUID(), celsius: 18.0, waterLevel: 1.7, velocity: 4.5, noiseLevel: 45.0, date: Date(timeIntervalSinceNow: -7_200_000), time: Date()),
     TemperatureData(id: UUID(), celsius: 20.5, waterLevel: 2.4, velocity: 5.0, noiseLevel: 50.0, date: Date(timeIntervalSinceNow: -14_400_000), time: Date()),
     TemperatureData(id: UUID(), celsius: 15.0, waterLevel: 2.5, velocity: 3.5, noiseLevel: 48.0, date: Date(timeIntervalSinceNow: -21_600_000), time: Date()),
     TemperatureData(id: UUID(), celsius: 17.5, waterLevel: 1.2, velocity: 4.0, noiseLevel: 46.0, date: Date(timeIntervalSinceNow: -28_800_000), time: Date()),
     TemperatureData(id: UUID(), celsius: 21.0, waterLevel: 1.8, velocity: 6.0, noiseLevel: 49.0, date: Date(timeIntervalSinceNow: -36_000_000), time: Date())
     ]
     
     // Generate random temperature data for the last three months
     static func threeMonthsExamples() -> [TemperatureData] {
     let threeMonthsAgo = Calendar.current.date(byAdding: .month, value: -3, to: Date())!
     
     let exampleTemperatureData: [TemperatureData] = (1...300).map { _ in
     let randomCelsius = Float.random(in: -10...40) // Example temperature range
     let randomWaterLevel = Float.random(in: 0.5...2.5)
     let randomVelocity = Float.random(in: 0...10) // Example range for velocity
     let randomNoiseLevel = Float.random(in: 40...70) // Example range for noise level
     let randomDate = Date.random(in: threeMonthsAgo...Date())
     
     return TemperatureData(
     id: UUID(),
     celsius: randomCelsius,
     waterLevel: randomWaterLevel,
     velocity: randomVelocity,
     noiseLevel: randomNoiseLevel,
     date: randomDate,
     time: randomDate
     )
     }
     return exampleTemperatureData.sorted { $0.date < $1.date }
     }
     
     // Example data with higher temperatures on weekends
     static var higherWeekendThreeMonthsExamples: [TemperatureData] = {
     let threeMonthsAgo = Calendar.current.date(byAdding: .month, value: -3, to: Date())!
     let exampleTemperatureData: [TemperatureData] = (1...300).map { _ in
     let randomDate = Date.random(in: threeMonthsAgo...Date())
     let weekday = Calendar.current.component(.weekday, from: randomDate)
     
     let averageCelsius: Float = (weekday == 7 || weekday == 1) ? 25.0 : 20.0 // Higher average for weekends
     let randomCelsius = Float.random(in: averageCelsius - 2...averageCelsius + 2)
     
     let averageWaterLevel: Float = (weekday == 7 || weekday == 1) ? 2.0 : 1.0
     let randomWaterLevel = Float.random(in: averageWaterLevel - 0.5...averageWaterLevel + 0.5)
     
     let randomVelocity = Float.random(in: 0...10) // Example range for velocity
     let randomNoiseLevel = Float.random(in: 40...70) // Example range for noise level
     
     return TemperatureData(
     id: UUID(),
     celsius: randomCelsius,
     waterLevel: randomWaterLevel,
     velocity: randomVelocity,
     noiseLevel: randomNoiseLevel,
     date: randomDate,
     time: randomDate
     )
     }
     return exampleTemperatureData.sorted { $0.date < $1.date }
     }()
     }
     
     
     
     
     */
}

class TemperatureJSON: Codable {
    let temperatureArray: [TemperatureData]
    
    init(temperatureArray: [TemperatureData]) {
        self.temperatureArray = temperatureArray
    }

    // Manual Decodable conformance
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.temperatureArray = try container.decode([TemperatureData].self, forKey: .temperatureArray)
    }
    
    // Manual Encodable conformance (optional, if you also want to encode)
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(temperatureArray, forKey: .temperatureArray)
    }

    private enum CodingKeys: String, CodingKey {
        case temperatureArray
    }
}

/*
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

 
 */
