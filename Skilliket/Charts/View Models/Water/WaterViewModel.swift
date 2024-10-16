//
//  WaterViewModel.swift
//  Skilliket
//
//  Created by Nicole  on 15/10/24.
//

import Foundation

class WaterViewModel: ObservableObject{
    
    @Published var waterData: [WaterData]
    @Published var lastTotalLevel: Float = 0
    
    var totalLevel: Float {
        waterData.reduce(0) { $0 + $1.waterLevel }
    }
    
    var medianLevel: Double {
        let waterData = self.averageLevelByWeekday
        return calculateMedian(waterData: waterData) ?? 0
    }
    
    var waterByDay: [(day: Date, level: Float)] {
        let grouped = waterGroupedByDay(water: waterData)
        return totalLevelPerDate(waterByDate: grouped)
    }
    
    var waterByWeek: [(week: Date, level: Float)] {
        let grouped = waterGroupedByWeek(water: waterData)
        return totalLevelPerWeek(waterByWeek: grouped)
    }

    
    var waterByMonth: [(month: Date, level: Float)] {
        let grouped = waterGroupedByMonth(water: waterData)
        return totalLevelPerMonth(waterByMonth: grouped)
    }
    
    var waterByWeekday: [(number: Int, level: [WaterData])] {
        let grouped = waterGroupedByWeekday(water: waterData).map {
            (number: $0.key, level: $0.value)
        }
        return grouped.sorted { $0.number < $1.number }
    }
    
    var averageLevelByWeekday: [(number: Int, water: Double)] {
        let waterByWeekday = waterGroupedByWeekday(water: waterData)
        let averageLevel = averageLevelPerNumber(waterByNumber: waterByWeekday)
        return averageLevel.map { (number: $0.number, water: $0.level) } // Change to 'wind'
    }

    
    var waterByWeekdayHistogramData: [(number: Int, histogram: [(bucket: Int, count: Int)])] {
        var result: [(number: Int, histogram: [(bucket: Int, count: Int)])] = []
        let waterByWeekdayData = self.waterByWeekday
        for data in waterByWeekdayData {
            result.append((number: data.number, histogram: histogram(for: data.level, bucketSize: 5)))
        }
        return result
    }
    
    var highestLevelWeekday: (number: Int, water: Double)? {
        averageLevelByWeekday.max(by: { $0.water < $1.water })
    }
    
    // Initializers
    init(waterData: [WaterData] = [], lastTotalLevel: Float = 0.0) {
        self.waterData = waterData
        self.lastTotalLevel = lastTotalLevel
    }
    
    convenience init() {
        self.init(waterData: WaterData.higherWeekendThreeMonthsExamples, lastTotalLevel: 2000.0)
    }
    
    // MARK: - Helper Functions
    
    // Group wind data by day
    func waterGroupedByDay(water: [WaterData]) -> [Date: [WaterData]] {
        var waterByDay: [Date: [WaterData]] = [:]
        let calendar = Calendar.current
        for entry in water {
            let date = calendar.startOfDay(for: entry.date)
            waterByDay[date, default: []].append(entry)
        }
        return waterByDay
    }
    
    // Group wind data by week
    func waterGroupedByWeek(water: [WaterData]) -> [Date: [WaterData]] {
        var waterByWeek: [Date: [WaterData]] = [:]
        let calendar = Calendar.current
        for entry in water {
            guard let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: entry.date)) else { continue }
            waterByWeek[startOfWeek, default: []].append(entry)
        }
        return waterByWeek
    }
    
    // Group wind data by month
    func waterGroupedByMonth(water: [WaterData]) -> [Date: [WaterData]] {
        var waterByMonth: [Date: [WaterData]] = [:]
        let calendar = Calendar.current
        for entry in water {
            guard let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: entry.date)) else { continue }
            waterByMonth[startOfMonth, default: []].append(entry)
        }
        return waterByMonth
    }
    
    // Group wind data by weekday
    func waterGroupedByWeekday(water: [WaterData]) -> [Int: [WaterData]] {
        var waterByWeekday: [Int: [WaterData]] = [:]
        let calendar = Calendar.current
        for entry in water {
            let weekday = calendar.component(.weekday, from: entry.date)
            waterByWeekday[weekday, default: []].append(entry)
        }
        return waterByWeekday
    }
    
    
    // Calculate total velocity per date
    func totalLevelPerDate(waterByDate: [Date: [WaterData]]) -> [(day: Date, level: Float)] {
        var totalLevel: [(day: Date, level: Float)] = []
        for (date, waterEntries) in waterByDate {
            let totalLevelForDate = waterEntries.reduce(0) { $0 + $1.waterLevel }
            totalLevel.append((day: date, level: totalLevelForDate))
        }
        return totalLevel.sorted { $0.day < $1.day }
    }

    func totalLevelPerWeek(waterByWeek: [Date: [WaterData]]) -> [(week: Date, level: Float)] {
        var totalLevel: [(week: Date, level: Float)] = []
        for (week, waterEntries) in waterByWeek {
            let totalLevelForWeek = waterEntries.reduce(0) { $0 + $1.waterLevel }
            totalLevel.append((week: week, level: totalLevelForWeek))
        }
        return totalLevel.sorted { $0.week < $1.week }
    }

    func totalLevelPerMonth(waterByMonth: [Date: [WaterData]]) -> [(month: Date, level: Float)] {
        var totalLevel: [(month: Date, level: Float)] = []
        for (month, waterEntries) in waterByMonth {
            let totalLevelForMonth = waterEntries.reduce(0) { $0 + $1.waterLevel }
            totalLevel.append((month: month, level: totalLevelForMonth))
        }
        return totalLevel.sorted { $0.month < $1.month }
    }

    
    // Calculate average velocity per weekday number
    func averageLevelPerNumber(waterByNumber: [Int: [WaterData]]) -> [(number: Int, level: Double)] {
        var averageLevel: [(number: Int, level: Double)] = []
        for (number, waterEntries) in waterByNumber {
            let count = waterEntries.count
            guard count > 0 else { continue }
            let totalLevelForWeekday = waterEntries.reduce(0) { $0 + $1.waterLevel }
            let average = Double(totalLevelForWeekday) / Double(count)
            averageLevel.append((number: number, level: average))
        }
        return averageLevel
    }
    
    // Generate histogram for wind velocities
    func histogram(for levels: [WaterData], bucketSize: Int) -> [(bucket: Int, count: Int)] {
        var histogram: [Int: Int] = [:]
        for entry in levels {
            let bucket = Int(entry.waterLevel) / bucketSize
            histogram[bucket, default: 0] += 1
        }
        return histogram.map { (bucket: $0.key, count: $0.value) }.sorted { $0.bucket < $1.bucket }
    }

    // Calculate median velocity
    func calculateMedian(waterData: [(number: Int, water: Double)]) -> Double? {
        let levels = waterData.map { $0.water }.sorted()
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
    
    static var preview: WaterViewModel {
        let vm = WaterViewModel()
        vm.waterData = WaterData.higherWeekendThreeMonthsExamples
        vm.lastTotalLevel = 2000.0 // Example value
        return vm
    }
}
    
    
    
