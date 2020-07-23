//
//  DateExtension.swift
//  UI-HotelBookingApp
//
//  Created by Valentin Malissen on 2020-07-22.
//
import SwiftUI

extension Date {
    func year() -> Int {
        let components = Calendar.current.dateComponents([.year], from: self)
        guard let year = components.year else { return -1 }
        return year
    }
    
    func addMonth(_ number: Int) -> Date {
        var dateComponent = DateComponents()
        dateComponent.month = number
        return Calendar.current.date(byAdding: dateComponent, to: self)!
    }
    
    func addDay(_ number: Int) -> Date {
        var dateComponent = DateComponents()
        dateComponent.day = number
        return Calendar.current.date(byAdding: dateComponent, to: self)!
    }
    
    
    func getFirstWeekDay() -> Int {
        let calendar = Calendar.current
        let interval = calendar.dateInterval(of: .month, for: self)
        if let startMonth = interval?.start {
            let components = calendar.dateComponents([.weekday], from: startMonth)
            return components.weekday!
        }
        return -1
    }
    
    func getNumberOfDaysInMonth() -> Int {
        let calendar = Calendar.current
        let interval = calendar.dateInterval(of: .month, for: self)
        if let month = interval {
            let days = calendar.dateComponents([.day], from: month.start, to: month.end).day!
            return days
        }
        return -1
    }
    
    func equals(to d: Date) -> Bool {
        return Calendar.current.compare(self, to: d, toGranularity: .day) == ComparisonResult.orderedSame
    }
    
    func lessThan(to d:Date) -> Bool {
        return Calendar.current.compare(self, to: d, toGranularity: .day) == ComparisonResult.orderedAscending
    }

    func greaterThan(to d:Date) -> Bool {
        return Calendar.current.compare(self, to: d, toGranularity: .day) == ComparisonResult.orderedDescending
    }
}
