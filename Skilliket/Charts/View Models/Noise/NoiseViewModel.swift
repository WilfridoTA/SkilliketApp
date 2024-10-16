//
//  NoiseViewModel.swift
//  Skilliket
//
//  Created by Nicole  on 15/10/24.
//

import Foundation

class NoiseViewModel: ObservableObject {
    
    // Published properties to update the UI
    @Published var noiseData: [NoiseData] = []
    @Published var lastTotalLevel: Float = 0
    
    // Computed Properties
    var totalLevel: Float {
        noiseData.reduce(0) { $0 + $1.noiseLevel }
    }
    
    var medianLevel: Double {
        let noiseData = self.averageLevelByWeekday
        return calculateMedian(noiseData: noiseData) ?? 0
    }
    
    var noiseByDay: [(day: Date, level: Float)] {
        let grouped = noiseGroupedByDay(noise: noiseData)
        return totalLevelPerDate(noiseByDate: grouped)
    }
    
    var noiseByWeek: [(week: Date, level: Float)] {
        let grouped = noiseGroupedByWeek(noise: noiseData)
        return totalLevelPerWeek(noiseByWeek: grouped)
    }

    var noiseByMonth: [(month: Date, level: Float)] {
        let grouped = noiseGroupedByMonth(noise: noiseData)
        return totalLevelPerMonth(noiseByMonth: grouped)
    }
    
    var noiseByWeekday: [(number: Int, level: [NoiseData])] {
        let grouped = noiseGroupedByWeekday(noise: noiseData).map {
            (number: $0.key, level: $0.value)
        }
        return grouped.sorted { $0.number < $1.number }
    }
    
    var averageLevelByWeekday: [(number: Int, noise: Double)] {
        let noiseByWeekday = noiseGroupedByWeekday(noise: noiseData)
        let averageLevel = averageLevelPerNumber(noiseByNumber: noiseByWeekday)
        return averageLevel.map { (number: $0.number, noise: $0.level) }
    }

    var noiseByWeekdayHistogramData: [(number: Int, histogram: [(bucket: Int, count: Int)])] {
        var result: [(number: Int, histogram: [(bucket: Int, count: Int)])] = []
        let noiseByWeekdayData = self.noiseByWeekday
        for data in noiseByWeekdayData {
            result.append((number: data.number, histogram: histogram(for: data.level, bucketSize: 5)))
        }
        return result
    }
    
    var highestLevelWeekday: (number: Int, noise: Double)? {
        averageLevelByWeekday.max(by: { $0.noise < $1.noise })
    }
    
    // Initializers
    init(noiseData: [NoiseData] = [], lastTotalLevel: Float = 0.0) {
        self.noiseData = noiseData
        self.lastTotalLevel = lastTotalLevel
    }
    
    /*
    convenience init() {
        self.init(waterData: WaterData.higherWeekendThreeMonthsExamples, lastTotalLevel: 2000.0)
    }
    */
    
    // MARK: - Helper Functions
    
    // Group noise data by day
    func noiseGroupedByDay(noise: [NoiseData]) -> [Date: [NoiseData]] {
        var noiseByDay: [Date: [NoiseData]] = [:]
        let calendar = Calendar.current
        for entry in noise {
            let date = calendar.startOfDay(for: entry.date)
            noiseByDay[date, default: []].append(entry)
        }
        return noiseByDay
    }
    
    // Group noise data by week
    func noiseGroupedByWeek(noise: [NoiseData]) -> [Date: [NoiseData]] {
        var noiseByWeek: [Date: [NoiseData]] = [:]
        let calendar = Calendar.current
        for entry in noise {
            guard let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: entry.date)) else { continue }
            noiseByWeek[startOfWeek, default: []].append(entry)
        }
        return noiseByWeek
    }
    
    // Group noise data by month
    func noiseGroupedByMonth(noise: [NoiseData]) -> [Date: [NoiseData]] {
        var noiseByMonth: [Date: [NoiseData]] = [:]
        let calendar = Calendar.current
        for entry in noise {
            guard let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: entry.date)) else { continue }
            noiseByMonth[startOfMonth, default: []].append(entry)
        }
        return noiseByMonth
    }
    
    // Group noise data by weekday
    func noiseGroupedByWeekday(noise: [NoiseData]) -> [Int: [NoiseData]] {
        var noiseByWeekday: [Int: [NoiseData]] = [:]
        let calendar = Calendar.current
        for entry in noise {
            let weekday = calendar.component(.weekday, from: entry.date)
            noiseByWeekday[weekday, default: []].append(entry)
        }
        return noiseByWeekday
    }
    
    // Calculate total level per date
    func totalLevelPerDate(noiseByDate: [Date: [NoiseData]]) -> [(day: Date, level: Float)] {
        var totalLevel: [(day: Date, level: Float)] = []
        for (date, noiseEntries) in noiseByDate {
            let totalLevelForDate = noiseEntries.reduce(0) { $0 + $1.noiseLevel }
            totalLevel.append((day: date, level: totalLevelForDate))
        }
        return totalLevel.sorted { $0.day < $1.day }
    }
    
    func totalLevelPerWeek(noiseByWeek: [Date: [NoiseData]]) -> [(week: Date, level: Float)] {
        var totalLevel: [(week: Date, level: Float)] = []
        for (week, noiseEntries) in noiseByWeek {
            let totalLevelForWeek = noiseEntries.reduce(0) { $0 + $1.noiseLevel }
            totalLevel.append((week: week, level: totalLevelForWeek))
        }
        return totalLevel.sorted { $0.week < $1.week }
    }

    func totalLevelPerMonth(noiseByMonth: [Date: [NoiseData]]) -> [(month: Date, level: Float)] {
        var totalLevel: [(month: Date, level: Float)] = []
        for (month, noiseEntries) in noiseByMonth {
            let totalLevelForMonth = noiseEntries.reduce(0) { $0 + $1.noiseLevel }
            totalLevel.append((month: month, level: totalLevelForMonth))
        }
        return totalLevel.sorted { $0.month < $1.month }
    }
    
    // Calculate average level per weekday number
    func averageLevelPerNumber(noiseByNumber: [Int: [NoiseData]]) -> [(number: Int, level: Double)] {
        var averageLevel: [(number: Int, level: Double)] = []
        for (number, noiseEntries) in noiseByNumber {
            let count = noiseEntries.count
            guard count > 0 else { continue }
            let totalLevelForWeekday = noiseEntries.reduce(0) { $0 + $1.noiseLevel }
            let average = Double(totalLevelForWeekday) / Double(count)
            averageLevel.append((number: number, level: average))
        }
        return averageLevel
    }
    
    // Generate histogram for noise levels
    func histogram(for levels: [NoiseData], bucketSize: Int) -> [(bucket: Int, count: Int)] {
        var histogram: [Int: Int] = [:]
        for entry in levels {
            let bucket = Int(entry.noiseLevel) / bucketSize
            histogram[bucket, default: 0] += 1
        }
        return histogram.map { (bucket: $0.key, count: $0.value) }.sorted { $0.bucket < $1.bucket }
    }

    // Calculate median noise level
    func calculateMedian(noiseData: [(number: Int, noise: Double)]) -> Double? {
        let levels = noiseData.map { $0.noise }.sorted()
        let count = levels.count
        
        guard count > 0 else { return nil }
        
        if count % 2 == 0 {
            let middleIndex = count / 2
            let median = (levels[middleIndex - 1] + levels[middleIndex]) / 2
            return median
        } else {
            let middleIndex = count / 2
            return levels[middleIndex]
        }
    }
    
    // MARK: - Preview
    
    static var preview: NoiseViewModel {
        let vm = NoiseViewModel()
    //vm.noiseData = NoiseData.higherWeekendThreeMonthsExamples
        vm.lastTotalLevel = 2000.0 // Example value
        return vm
    }
}
