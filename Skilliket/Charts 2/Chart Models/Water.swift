//
//  Water.swift
//  Skilliket
//
//  Created by Nicole  on 16/10/24.
//

import Foundation
struct WaterData2: Identifiable, Equatable, Codable {
    let id: UUID
    let waterLevel: Float
    let velocity: Float
    let celsius: Float
    let noiseLevel: Float
    let date: Date
    let time: Date

    // Example instance for demonstration purposes
    static var example = WaterData2(
        id: UUID(),
        waterLevel: 1.5,
        velocity: 5.0,
        celsius: 22.0,
        noiseLevel: 50.0,
        date: Date(),
        time: Date()
    )

    // Array of example instances
    static var examples: [WaterData2] = [
        WaterData2(id: UUID(), waterLevel: 1.2, velocity: 4.5, celsius: 20.0, noiseLevel: 45.3, date: Date(timeIntervalSinceNow: -7_200_000), time: Date()),
        WaterData2(id: UUID(), waterLevel: 1.8, velocity: 5.2, celsius: 21.0, noiseLevel: 55.8, date: Date(timeIntervalSinceNow: -14_400_000), time: Date()),
        WaterData2(id: UUID(), waterLevel: 2.0, velocity: 5.8, celsius: 22.5, noiseLevel: 49.5, date: Date(timeIntervalSinceNow: -21_600_000), time: Date()),
        WaterData2(id: UUID(), waterLevel: 0.9, velocity: 3.5, celsius: 19.5, noiseLevel: 60.2, date: Date(timeIntervalSinceNow: -28_800_000), time: Date()),
        WaterData2(id: UUID(), waterLevel: 1.6, velocity: 6.0, celsius: 23.0, noiseLevel: 42.1, date: Date(timeIntervalSinceNow: -36_000_000), time: Date())
    ]

    // Generates water level data for the last three months
    static func threeMonthsExamples() -> [WaterData2] {
        let threeMonthsAgo = Calendar.current.date(byAdding: .month, value: -3, to: Date())!

        let exampleWaterData: [WaterData2] = (1...300).map { _ in
            let randomWaterLevel = Float.random(in: 0.5...2.5) // Example range for water level
            let randomVelocity = Float.random(in: 0...10) // Example range for velocity
            let randomCelsius = Float.random(in: 15...30) // Example range for temperature
            let randomNoiseLevel = Float.random(in: 30.0...70.0)
            let randomDate = Date.random(in: threeMonthsAgo...Date())

            return WaterData2(
                id: UUID(),
                waterLevel: randomWaterLevel,
                velocity: randomVelocity,
                celsius: randomCelsius,
                noiseLevel: randomNoiseLevel,
                date: randomDate,
                time: randomDate
            )
        }
        return exampleWaterData.sorted { $0.date < $1.date }
    }

    // Generates weekend data with higher noise levels
    static var higherWeekendThreeMonthsExamples: [WaterData2] = {
        let threeMonthsAgo = Calendar.current.date(byAdding: .month, value: -3, to: Date())!
        let exampleWaterData: [WaterData2] = (1...300).map { _ in
            let randomDate = Date.random(in: threeMonthsAgo...Date())
            let weekday = Calendar.current.component(.weekday, from: randomDate)

            // Higher noise levels on weekends
            let averageNoiseLevel: Float = (weekday == 7 || weekday == 1) ? 60.0 : 45.0
            let randomNoiseLevel = Float.random(in: averageNoiseLevel - 5.0...averageNoiseLevel + 5.0)
            let randomWaterLevel = Float.random(in: 0.5...2.5) // Example range for water level
            let randomVelocity = Float.random(in: 0...10) // Example range for velocity
            let randomCelsius = Float.random(in: 15...30) // Example range for temperature

            return WaterData2(
                id: UUID(),
                waterLevel: randomWaterLevel,
                velocity: randomVelocity,
                celsius: randomCelsius,
                noiseLevel: randomNoiseLevel,
                date: randomDate,
                time: randomDate
            )
        }
        return exampleWaterData.sorted { $0.date < $1.date }
    }()
}
