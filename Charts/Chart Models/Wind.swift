//
//  Wind.swift
//  Skilliket
//
//  Created by Nicole  on 12/10/24.
//


import Foundation

struct WindData: Identifiable, Equatable, Codable {
    let id: UUID
    let velocity: Float
    
    let date: Date
    let time: Date
    
    /*
     // Example instance for demonstration purposes
     static var example = WindData(
     id: UUID(),
     velocity: 5.0,
     waterLevel: 1.5,
     noiseLevel: 50.0,
     celsius: 22.0,
     date: Date(),
     time: Date()
     )
     
     // Array of example instances
     static var examples: [WindData] = [
     WindData(id: UUID(), velocity: 4.3, waterLevel: 1.2, noiseLevel: 48.0, celsius: 20.0, date: Date(timeIntervalSinceNow: -7_200_000), time: Date()),
     WindData(id: UUID(), velocity: 3.8, waterLevel: 1.8, noiseLevel: 52.0, celsius: 21.0, date: Date(timeIntervalSinceNow: -14_400_000), time: Date()),
     WindData(id: UUID(), velocity: 5.5, waterLevel: 2.0, noiseLevel: 55.0, celsius: 22.5, date: Date(timeIntervalSinceNow: -21_600_000), time: Date()),
     WindData(id: UUID(), velocity: 6.2, waterLevel: 0.9, noiseLevel: 47.0, celsius: 19.5, date: Date(timeIntervalSinceNow: -28_800_000), time: Date()),
     WindData(id: UUID(), velocity: 4.1, waterLevel: 1.6, noiseLevel: 49.0, celsius: 23.0, date: Date(timeIntervalSinceNow: -36_000_000), time: Date())
     ]
     
     // Generates wind data for the last three months
     static func threeMonthsExamples() -> [WindData] {
     let threeMonthsAgo = Calendar.current.date(byAdding: .month, value: -3, to: Date())!
     
     let exampleWindData: [WindData] = (1...300).map { _ in
     let randomVelocity = Float.random(in: 0...10)
     let randomWaterLevel = Float.random(in: 0.5...2.5) // Example range for water level
     let randomNoiseLevel = Float.random(in: 40...70) // Example range for noise level
     let randomCelsius = Float.random(in: 15...30) // Example range for temperature
     let randomDate = Date.random(in: threeMonthsAgo...Date())
     
     return WindData(
     id: UUID(),
     velocity: randomVelocity,
     waterLevel: randomWaterLevel,
     noiseLevel: randomNoiseLevel,
     celsius: randomCelsius,
     date: randomDate,
     time: randomDate
     )
     }
     return exampleWindData.sorted { $0.date < $1.date }
     }
     
     // Generates weekend data with higher wind velocities
     static var higherWeekendThreeMonthsExamples: [WindData] = {
     let threeMonthsAgo = Calendar.current.date(byAdding: .month, value: -3, to: Date())!
     let exampleWindData: [WindData] = (1...300).map { _ in
     let randomDate = Date.random(in: threeMonthsAgo...Date())
     let weekday = Calendar.current.component(.weekday, from: randomDate)
     
     // Higher wind velocities on weekends
     let averageVelocity: Float = (weekday == 7 || weekday == 1) ? 8.0 : 4.0
     let randomVelocity = Float.random(in: averageVelocity - 2...averageVelocity + 2)
     let randomWaterLevel = Float.random(in: 0.5...2.5) // Example range for water level
     let randomNoiseLevel = Float.random(in: 40...70) // Example range for noise level
     let randomCelsius = Float.random(in: 15...30) // Example range for temperature
     
     return WindData(
     id: UUID(),
     velocity: randomVelocity,
     waterLevel: randomWaterLevel,
     noiseLevel: randomNoiseLevel,
     celsius: randomCelsius,
     date: randomDate,
     time: randomDate
     )
     }
     return exampleWindData.sorted { $0.date < $1.date }
     }()
     }
     
     // Extension for generating random Date
     extension Date {
     static func random(in range: ClosedRange<Date>) -> Date {
     let diff = range.upperBound.timeIntervalSinceReferenceDate - range.lowerBound.timeIntervalSinceReferenceDate
     let randomValue = diff * Double.random(in: 0...1) + range.lowerBound.timeIntervalSinceReferenceDate
     return Date(timeIntervalSinceReferenceDate: randomValue)
     }
     }
     
     */
}
class WindJSON: Codable {
    let windArray: [WindData]

    init(windArray: [WindData]) {
        self.windArray = windArray
    }

    // Manual Decodable conformance
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.windArray = try container.decode([WindData].self, forKey: .windArray)
    }

    // Manual Encodable conformance (optional, if you also want to encode)
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(windArray, forKey: .windArray)
    }

    private enum CodingKeys: String, CodingKey {
        case windArray
    }
}

/*
 
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
 */


