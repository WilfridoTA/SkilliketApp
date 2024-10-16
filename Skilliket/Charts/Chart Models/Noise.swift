//
//  Noise.swift
//  Skilliket
//
//  Created by Nicole  on 15/10/24.
//

import Foundation

struct NoiseData2: Identifiable, Equatable, Codable {
    let id: UUID
    let noiseLevel: Float
    let waterLevel: Float
    let velocity: Float
    let celsius: Float

    
    let date: Date
    let time: Date
    
    
    
     // Example instance for demonstration purposes
     static var example = NoiseData2(
     id: UUID(),
     noiseLevel: 50.0,
     waterLevel: 1.5,
     velocity: 5.0,
     celsius: 22.0,
     date: Date(),
     time: Date()
     )
     
     // Array of example instances
     static var examples: [NoiseData2] = [
     NoiseData2(id: UUID(), noiseLevel: 45.3, waterLevel: 1.2, velocity: 4.5, celsius: 20.0, date: Date(timeIntervalSinceNow: -7_200_000), time: Date()),
     NoiseData2(id: UUID(), noiseLevel: 55.8, waterLevel: 1.8, velocity: 5.2, celsius: 21.0, date: Date(timeIntervalSinceNow: -14_400_000), time: Date()),
     NoiseData2(id: UUID(), noiseLevel: 49.5, waterLevel: 2.0, velocity: 5.8, celsius: 22.5, date: Date(timeIntervalSinceNow: -21_600_000), time: Date()),
     NoiseData2(id: UUID(), noiseLevel: 60.2, waterLevel: 0.9, velocity: 3.5, celsius: 19.5, date: Date(timeIntervalSinceNow: -28_800_000), time: Date()),
     NoiseData2(id: UUID(), noiseLevel: 42.1, waterLevel: 1.6, velocity: 6.0, celsius: 23.0, date: Date(timeIntervalSinceNow: -36_000_000), time: Date())
     ]
     
     // Generates noise level data for the last three months
     static func threeMonthsExamples() -> [NoiseData2] {
     let threeMonthsAgo = Calendar.current.date(byAdding: .month, value: -3, to: Date())!
     
     let exampleNoiseData: [NoiseData2] = (1...300).map { _ in
     let randomNoiseLevel = Float.random(in: 30.0...70.0)
     let randomWaterLevel = Float.random(in: 0.5...2.5) // Example range for water level
     let randomVelocity = Float.random(in: 0...10) // Example range for velocity
     let randomCelsius = Float.random(in: 15...30) // Example range for temperature
     let randomDate = Date.random(in: threeMonthsAgo...Date())
     
     return NoiseData2(
     id: UUID(),
     noiseLevel: randomNoiseLevel,
     waterLevel: randomWaterLevel,
     velocity: randomVelocity,
     celsius: randomCelsius,
     date: randomDate,
     time: randomDate
     )
     }
     return exampleNoiseData.sorted { $0.date < $1.date }
     }
     
     // Generates weekend data with higher noise levels
     static var higherWeekendThreeMonthsExamples: [NoiseData2] = {
     let threeMonthsAgo = Calendar.current.date(byAdding: .month, value: -3, to: Date())!
     let exampleNoiseData: [NoiseData2] = (1...300).map { _ in
     let randomDate = Date.random(in: threeMonthsAgo...Date())
     let weekday = Calendar.current.component(.weekday, from: randomDate)
     
     // Higher noise levels on weekends
     let averageNoiseLevel: Float = (weekday == 7 || weekday == 1) ? 60.0 : 45.0
     let randomNoiseLevel = Float.random(in: averageNoiseLevel - 5.0...averageNoiseLevel + 5.0)
     let randomWaterLevel = Float.random(in: 0.5...2.5) // Example range for water level
     let randomVelocity = Float.random(in: 0...10) // Example range for velocity
     let randomCelsius = Float.random(in: 15...30) // Example range for temperature
     
     return NoiseData2(
     id: UUID(),
     noiseLevel: randomNoiseLevel,
     waterLevel: randomWaterLevel,
     velocity: randomVelocity,
     celsius: randomCelsius,
     date: randomDate,
     time: randomDate
     )
     }
     return exampleNoiseData.sorted { $0.date < $1.date }
     }()
     }
     
     
    


/*
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
 */
