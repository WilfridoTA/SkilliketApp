//
//  TemperatureViewModel.swift
//  Skilliket
//
//  Created by Nicole  on 16/10/24.
//

import Foundation

class TemperatureViewModel: ObservableObject {
    
    // Published properties to update the UI
    @Published var temperatureData: [TemperatureData2]
    @Published var lastTotalCelsius: Float = 0
    
    // Computed Properties
    var totalCelsius: Float {
        temperatureData.reduce(0) { $0 + $1.celsius }
    }
    
    var medianCelsius: Double {
        let temperatureData = self.averageCelsiusByWeekday
        return calculateMedian(temperatureData: temperatureData) ?? 0
    }
    
    var temperatureByDay: [(day: Date, celsius: Float)] {
        let grouped = temperatureGroupedByDay(temperature: temperatureData)
        return totalCelsiusPerDate(temperatureByDate: grouped)
    }
    
    var temperatureByWeek: [(week: Date, celsius: Float)] {
        let grouped = temperatureGroupedByWeek(temperature: temperatureData)
        return totalCelsiusPerWeek(temperatureByWeek: grouped)
    }

    
    var temperatureByMonth: [(month: Date, celsius: Float)] {
        let grouped = temperatureGroupedByMonth(temperature: temperatureData)
        return totalCelsiusPerMonth(temperatureByMonth: grouped)
    }
    
    var temperatureByWeekday: [(number: Int, celsius: [TemperatureData2])] {
        let grouped = temperatureGroupedByWeekday(temperature: temperatureData).map {
            (number: $0.key, celsius: $0.value)
        }
        return grouped.sorted { $0.number < $1.number }
    }
    
    var averageCelsiusByWeekday: [(number: Int, temperature: Double)] {
        let temperaturesByWeekday = temperatureGroupedByWeekday(temperature: temperatureData)
        let averageCelsius = averageCelsiusPerNumber(temperatureByNumber: temperaturesByWeekday)
        return averageCelsius.map { (number: $0.number, temperature: $0.celsius) }
    }

    
    var temperatureByWeekdayHistogramData: [(number: Int, histogram: [(bucket: Int, count: Int)])] {
        var result: [(number: Int, histogram: [(bucket: Int, count: Int)])] = []
        let temperatureByWeekdayData = self.temperatureByWeekday
        for data in temperatureByWeekdayData {
            result.append((number: data.number, histogram: histogram(for: data.celsius, bucketSize: 5)))
        }
        return result
    }
    
    var highestCelsiusWeekday: (number: Int, temperature: Double)? {
        averageCelsiusByWeekday.max(by: { $0.temperature < $1.temperature })
    }
    
    
    // Initializers
    init(temperatureData: [TemperatureData2] = [], lastTotalCelsius: Float = 0.0) {
        self.temperatureData = temperatureData
        self.lastTotalCelsius = lastTotalCelsius
    }
    
    convenience init() {
        self.init(temperatureData: TemperatureData2.higherWeekendThreeMonthsExamples, lastTotalCelsius: 2000.0)
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
    
    
    // Calculate total celsius per date
    func totalCelsiusPerDate(temperatureByDate: [Date: [TemperatureData2]]) -> [(day: Date, celsius: Float)] {
        var totalCelsius: [(day: Date, celsius: Float)] = []
        for (date, temperatureEntries) in temperatureByDate {
            let totalCelsiusForDate = temperatureEntries.reduce(0) { $0 + $1.celsius }
            totalCelsius.append((day: date, celsius: totalCelsiusForDate))
        }
        return totalCelsius.sorted { $0.day < $1.day }
    }
    
    func totalCelsiusPerWeek(temperatureByWeek: [Date: [TemperatureData2]]) -> [(week: Date, celsius: Float)] {
        var totalTemperature: [(week: Date, celsius: Float)] = []
        for (week, temperatureEntries) in temperatureByWeek {
            let totalTemperatureForWeek = temperatureEntries.reduce(0) { $0 + $1.celsius }
            totalTemperature.append((week: week, celsius: totalTemperatureForWeek))
        }
        return totalTemperature.sorted { $0.week < $1.week }
    }


    func totalCelsiusPerMonth(temperatureByMonth: [Date: [TemperatureData2]]) -> [(month: Date, celsius: Float)] {
        var totalCelsius: [(month: Date, celsius: Float)] = []
        for (month, temperatureEntries) in temperatureByMonth {
            let totalCelsiusForMonth = temperatureEntries.reduce(0) { $0 + $1.celsius }
            totalCelsius.append((month: month, celsius: totalCelsiusForMonth))
        }
        return totalCelsius.sorted { $0.month < $1.month }
    }

    
    // Calculate average celsius per weekday number
    func averageCelsiusPerNumber(temperatureByNumber: [Int: [TemperatureData2]]) -> [(number: Int, celsius: Double)] {
        var averageCelsius: [(number: Int, celsius: Double)] = []
        for (number, temperatureEntries) in temperatureByNumber {
            let count = temperatureEntries.count
            guard count > 0 else { continue }
            let totalCelsiusForWeekday = temperatureEntries.reduce(0) { $0 + $1.celsius }
            let average = Double(totalCelsiusForWeekday) / Double(count)
            averageCelsius.append((number: number, celsius: average))
        }
        return averageCelsius
    }
    
    // Generate histogram for temperatures
    func histogram(for temperatures: [TemperatureData2], bucketSize: Int) -> [(bucket: Int, count: Int)] {
        var histogram: [Int: Int] = [:]
        for entry in temperatures {
            let bucket = Int(entry.celsius) / bucketSize
            histogram[bucket, default: 0] += 1
        }
        return histogram.map { (bucket: $0.key, count: $0.value) }.sorted { $0.bucket < $1.bucket }
    }

    // Calculate median temperature
    func calculateMedian(temperatureData: [(number: Int, temperature: Double)]) -> Double? {
        let temperatures = temperatureData.map { $0.temperature }.sorted()
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
        vm.temperatureData = TemperatureData2.higherWeekendThreeMonthsExamples
        vm.lastTotalCelsius = 2000.0 // Example value
        return vm
    }
}


