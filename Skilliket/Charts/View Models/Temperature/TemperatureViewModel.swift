//
//  TemperatureViewModel.swift
//  Skilliket
//
//  Created by Nicole  on 15/10/24.
//

import Foundation

class TemperatureViewModel: ObservableObject {
    
    // Published properties to update the UI
    @Published var temperatureData: [TemperatureData2]
    @Published var lastTotalTemp: Float = 0
    
    // Computed Properties
    var totalTemp: Float {
        temperatureData.reduce(0) { $0 + $1.celsius }
    }
    
    var medianTemp: Double {
        let temperatureData = self.averageTempByWeekday
        return calculateMedian(temperatureData: temperatureData) ?? 0
    }
    
    var tempByDay: [(day: Date, temp: Float)] {
        let grouped = temperatureGroupedByDay(temperature: temperatureData)
        return totalTempPerDate(temperatureByDate: grouped)
    }
    
    var tempByWeek: [(week: Date, temp: Float)] {
        let grouped = temperatureGroupedByWeek(temperature: temperatureData)
        return totalTempPerWeek(temperatureByWeek: grouped)
    }

    
    var tempByMonth: [(month: Date, temp: Float)] {
        let grouped = temperatureGroupedByMonth(temperature: temperatureData)
        return totalTempPerMonth(temperatureByMonth: grouped)
    }
    
    var tempByWeekday: [(number: Int, temp: [TemperatureData2])] {
        let grouped = temperatureGroupedByWeekday(temperature: temperatureData).map {
            (number: $0.key, temp: $0.value)
        }
        return grouped.sorted { $0.number < $1.number }
    }
    
    var averageTempByWeekday: [(number: Int, temp: Double)] {
        let temperaturesByWeekday = temperatureGroupedByWeekday(temperature: temperatureData)
        let averageTemp = averageTempPerNumber(temperatureByNumber: temperaturesByWeekday)
        return averageTemp.map { (number: $0.number, temp: $0.temp) } // Change to 'temp'
    }

    
    var tempByWeekdayHistogramData: [(number: Int, histogram: [(bucket: Int, count: Int)])] {
        var result: [(number: Int, histogram: [(bucket: Int, count: Int)])] = []
        let tempByWeekdayData = self.tempByWeekday
        for data in tempByWeekdayData {
            result.append((number: data.number, histogram: histogram(for: data.temp, bucketSize: 5)))
        }
        return result
    }
    
    var highestTempWeekday: (number: Int, temp: Double)? {
        averageTempByWeekday.max(by: { $0.temp < $1.temp }) // Change 'temp' to 'temp'
    }
    
    
    // Initializers
    init(temperatureData: [TemperatureData2] = [], lastTotalTemp: Float = 0.0) {
        self.temperatureData = temperatureData
        self.lastTotalTemp = lastTotalTemp
    }
    
    convenience init() {
        self.init(temperatureData: TemperatureData2.higherWeekendThreeMonthsExamples, lastTotalTemp: 20.0)
    }
    
    // MARK: - Helper Functions
    
    // Group temperature data by day
    func temperatureGroupedByDay(temperature: [TemperatureData2]) -> [Date: [TemperatureData2]] {
        var temperatureByDay: [Date: [TemperatureData2]] = [:]
        let calendar = Calendar.current
        for entry in temperature {
            let date = calendar.startOfDay(for: entry.date)
            temperatureByDay[date, default: []].append(entry)
        }
        return temperatureByDay
    }
    
    // Group temperature data by week
    func temperatureGroupedByWeek(temperature: [TemperatureData2]) -> [Date: [TemperatureData2]] {
        var temperatureByWeek: [Date: [TemperatureData2]] = [:]
        let calendar = Calendar.current
        for entry in temperature {
            guard let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: entry.date)) else { continue }
            temperatureByWeek[startOfWeek, default: []].append(entry)
        }
        return temperatureByWeek
    }
    
    // Group temperature data by month
    func temperatureGroupedByMonth(temperature: [TemperatureData2]) -> [Date: [TemperatureData2]] {
        var temperatureByMonth: [Date: [TemperatureData2]] = [:]
        let calendar = Calendar.current
        for entry in temperature {
            guard let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: entry.date)) else { continue }
            temperatureByMonth[startOfMonth, default: []].append(entry)
        }
        return temperatureByMonth
    }
    
    // Group temperature data by weekday
    func temperatureGroupedByWeekday(temperature: [TemperatureData2]) -> [Int: [TemperatureData2]] {
        var temperatureByWeekday: [Int: [TemperatureData2]] = [:]
        let calendar = Calendar.current
        for entry in temperature {
            let weekday = calendar.component(.weekday, from: entry.date)
            temperatureByWeekday[weekday, default: []].append(entry)
        }
        return temperatureByWeekday
    }
    
    
    // Calculate total temperature per date
    func totalTempPerDate(temperatureByDate: [Date: [TemperatureData2]]) -> [(day: Date, temp: Float)] {
        var totalTemp: [(day: Date, temp: Float)] = []
        for (date, temperatureEntries) in temperatureByDate {
            let totalTempForDate = temperatureEntries.reduce(0) { $0 + $1.celsius }
            totalTemp.append((day: date, temp: totalTempForDate))
        }
        return totalTemp.sorted { $0.day < $1.day }
    }
    
    func totalTempPerWeek(temperatureByWeek: [Date: [TemperatureData2]]) -> [(week: Date, temp: Float)] {
        var totalTemp: [(week: Date, temp: Float)] = []
        for (week, temperatureEntries) in temperatureByWeek {
            let totalTempForWeek = temperatureEntries.reduce(0) { $0 + $1.celsius }
            totalTemp.append((week: week, temp: totalTempForWeek))
        }
        return totalTemp.sorted { $0.week < $1.week }
    }

    func totalTempPerMonth(temperatureByMonth: [Date: [TemperatureData2]]) -> [(month: Date, temp: Float)] {
        var totalTemp: [(month: Date, temp: Float)] = []
        for (month, temperatureEntries) in temperatureByMonth {
            let totalTempForMonth = temperatureEntries.reduce(0) { $0 + $1.celsius }
            totalTemp.append((month: month, temp: totalTempForMonth))
        }
        return totalTemp.sorted { $0.month < $1.month }
    }

    
    // Calculate average temperature per weekday number
    func averageTempPerNumber(temperatureByNumber: [Int: [TemperatureData2]]) -> [(number: Int, temp: Double)] {
        var averageTemp: [(number: Int, temp: Double)] = []
        for (number, temperatureEntries) in temperatureByNumber {
            let count = temperatureEntries.count
            guard count > 0 else { continue }
            let totalTempForWeekday = temperatureEntries.reduce(0) { $0 + $1.celsius }
            let average = Double(totalTempForWeekday) / Double(count)
            averageTemp.append((number: number, temp: average))
        }
        return averageTemp
    }
    
    // Generate histogram for temperature readings
    func histogram(for temperatures: [TemperatureData2], bucketSize: Int) -> [(bucket: Int, count: Int)] {
        var histogram: [Int: Int] = [:]
        for entry in temperatures {
            let bucket = Int(entry.celsius) / bucketSize
            histogram[bucket, default: 0] += 1
        }
        return histogram.map { (bucket: $0.key, count: $0.value) }.sorted { $0.bucket < $1.bucket }
    }

    // Calculate median temperature
    func calculateMedian(temperatureData: [(number: Int, temp: Double)]) -> Double? {
        let temperatures = temperatureData.map { $0.temp }.sorted()
        let count = temperatures.count
        
        guard count > 0 else { return nil }
        
        if count % 2 == 0 {
            let middleIndex = count / 2
            let median = (temperatures[middleIndex - 1] + temperatures[middleIndex]) / 2
            return median
        } else {
            let middleIndex = count / 2
            return temperatures[middleIndex]
        }
    }
    
    // MARK: - Preview
    
    static var preview: TemperatureViewModel {
        let vm = TemperatureViewModel()
        vm.temperatureData = TemperatureData.higherWeekendThreeMonthsExamples
        vm.lastTotalTemp = 20.0 // Example value
        return vm
    }
}
