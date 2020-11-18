//
//  Date+Custom.swift
//
//
//  Created by Bastián Véliz Vega on 01-10-20.
//

import Foundation

public extension Date {
    func startOfMonth() -> Date? {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))
    }

    func endOfMonth() -> Date? {
        guard let startOfMonth = self.startOfMonth() else { return nil }
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth)
    }

    var monthName: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: self)
    }

    var yearName: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY"
        return dateFormatter.string(from: self)
    }

    var relativeDateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .medium
        dateFormatter.locale = Locale.current
        dateFormatter.doesRelativeDateFormatting = true
        return dateFormatter.string(from: self)
    }
}
