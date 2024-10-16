//
//  WindViewModel.swift
//  Skilliket
//
//  Created by Nicole  on 13/10/24.
//

import Foundation

class WindViewModel: ObservableObject {
    
    // Published properties to update the UI
    @Published var windData: [WindData2]
    @Published var lastTotalVelocity: Float = 0
    
    // Computed Properties
    var totalVelocity: Float {
        windData.reduce(0) { $0 + $1.velocity }
    }
    
    var medianVelocity: Double {
        let windData = self.averageVelocityByWeekday
        return calculateMedian(windData: windData) ?? 0
    }
    
    var windByDay: [(day: Date, velocity: Float)] {
        let grouped = windGroupedByDay(wind: windData)
        return totalVelocityPerDate(windByDate: grouped)
    }
    
    var windByWeek: [(week: Date, velocity: Float)] {
        let grouped = windGroupedByWeek(wind: windData)
        return totalVelocityPerWeek(windByWeek: grouped)
    }

    
    var windByMonth: [(month: Date, velocity: Float)] {
        let grouped = windGroupedByMonth(wind: windData)
        return totalVelocityPerMonth(windByMonth: grouped)
    }
    
    var windByWeekday: [(number: Int, velocity: [WindData2])] {
        let grouped = windGroupedByWeekday(wind: windData).map {
            (number: $0.key, velocity: $0.value)
        }
        return grouped.sorted { $0.number < $1.number }
    }
    
    var averageVelocityByWeekday: [(number: Int, wind: Double)] {
        let windsByWeekday = windGroupedByWeekday(wind: windData)
        let averageVelocity = averageVelocityPerNumber(windByNumber: windsByWeekday)
        return averageVelocity.map { (number: $0.number, wind: $0.velocity) } // Change to 'wind'
    }

    
    var windByWeekdayHistogramData: [(number: Int, histogram: [(bucket: Int, count: Int)])] {
        var result: [(number: Int, histogram: [(bucket: Int, count: Int)])] = []
        let windByWeekdayData = self.windByWeekday
        for data in windByWeekdayData {
            result.append((number: data.number, histogram: histogram(for: data.velocity, bucketSize: 5)))
        }
        return result
    }
    
    var highestVelocityWeekday: (number: Int, wind: Double)? {
        averageVelocityByWeekday.max(by: { $0.wind < $1.wind }) // Change 'velocity' to 'wind'
    }
    
    
    // Initializers
    init(windData: [WindData2] = [], lastTotalVelocity: Float = 0.0) {
        self.windData = windData
        self.lastTotalVelocity = lastTotalVelocity
    }
    
    convenience init() {
        self.init(windData: WindData2.higherWeekendThreeMonthsExamples, lastTotalVelocity: 2000.0)
    }
    
    // MARK: - Helper Functions
    
    // Group wind data by day
    func windGroupedByDay(wind: [WindData2]) -> [Date: [WindData2]] {
        var windByDay: [Date: [WindData2]] = [:]
        let calendar = Calendar.current
        for entry in wind {
            let date = calendar.startOfDay(for: entry.date)
            windByDay[date, default: []].append(entry)
        }
        return windByDay
    }
    
    // Group wind data by week
    func windGroupedByWeek(wind: [WindData2]) -> [Date: [WindData2]] {
        var windByWeek: [Date: [WindData2]] = [:]
        let calendar = Calendar.current
        for entry in wind {
            guard let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: entry.date)) else { continue }
            windByWeek[startOfWeek, default: []].append(entry)
        }
        return windByWeek
    }
    
    // Group wind data by month
    func windGroupedByMonth(wind: [WindData2]) -> [Date: [WindData2]] {
        var windByMonth: [Date: [WindData2]] = [:]
        let calendar = Calendar.current
        for entry in wind {
            guard let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: entry.date)) else { continue }
            windByMonth[startOfMonth, default: []].append(entry)
        }
        return windByMonth
    }
    
    // Group wind data by weekday
    func windGroupedByWeekday(wind: [WindData2]) -> [Int: [WindData2]] {
        var windByWeekday: [Int: [WindData2]] = [:]
        let calendar = Calendar.current
        for entry in wind {
            let weekday = calendar.component(.weekday, from: entry.date)
            windByWeekday[weekday, default: []].append(entry)
        }
        return windByWeekday
    }
    
    
    // Calculate total velocity per date
    func totalVelocityPerDate(windByDate: [Date: [WindData2]]) -> [(day: Date, velocity: Float)] {
        var totalVelocity: [(day: Date, velocity: Float)] = []
        for (date, windEntries) in windByDate {
            let totalVelocityForDate = windEntries.reduce(0) { $0 + $1.velocity }
            totalVelocity.append((day: date, velocity: totalVelocityForDate))
        }
        return totalVelocity.sorted { $0.day < $1.day }
    }
    
    func totalVelocityPerWeek(windByWeek: [Date: [WindData2]]) -> [(week: Date, velocity: Float)] {
        var totalVelocity: [(week: Date, velocity: Float)] = []
        for (week, windEntries) in windByWeek {
            let totalVelocityForWeek = windEntries.reduce(0) { $0 + $1.velocity }
            totalVelocity.append((week: week, velocity: totalVelocityForWeek))
        }
        return totalVelocity.sorted { $0.week < $1.week }
    }

    func totalVelocityPerMonth(windByMonth: [Date: [WindData2]]) -> [(month: Date, velocity: Float)] {
        var totalVelocity: [(month: Date, velocity: Float)] = []
        for (month, windEntries) in windByMonth {
            let totalVelocityForMonth = windEntries.reduce(0) { $0 + $1.velocity }
            totalVelocity.append((month: month, velocity: totalVelocityForMonth))
        }
        return totalVelocity.sorted { $0.month < $1.month }
    }

    
    // Calculate average velocity per weekday number
    func averageVelocityPerNumber(windByNumber: [Int: [WindData2]]) -> [(number: Int, velocity: Double)] {
        var averageVelocity: [(number: Int, velocity: Double)] = []
        for (number, windEntries) in windByNumber {
            let count = windEntries.count
            guard count > 0 else { continue }
            let totalVelocityForWeekday = windEntries.reduce(0) { $0 + $1.velocity }
            let average = Double(totalVelocityForWeekday) / Double(count)
            averageVelocity.append((number: number, velocity: average))
        }
        return averageVelocity
    }
    
    // Generate histogram for wind velocities
    func histogram(for velocities: [WindData2], bucketSize: Int) -> [(bucket: Int, count: Int)] {
        var histogram: [Int: Int] = [:]
        for entry in velocities {
            let bucket = Int(entry.velocity) / bucketSize
            histogram[bucket, default: 0] += 1
        }
        return histogram.map { (bucket: $0.key, count: $0.value) }.sorted { $0.bucket < $1.bucket }
    }

    // Calculate median velocity
    func calculateMedian(windData: [(number: Int, wind: Double)]) -> Double? {
        let velocities = windData.map { $0.wind }.sorted()
        let count = velocities.count
        
        guard count > 0 else { return nil }
        
        if count % 2 == 0 {
            let middleIndex = count / 2
            let median = (velocities[middleIndex - 1] + velocities[middleIndex]) / 2
            return median
        } else {
            let middleIndex = count / 2
            return velocities[middleIndex]
        }
    }
    
    // MARK: - Preview
    
    static var preview: WindViewModel {
        let vm = WindViewModel()
        vm.windData = WindData2.higherWeekendThreeMonthsExamples
        vm.lastTotalVelocity = 2000.0 // Example value
        return vm
    }
}

