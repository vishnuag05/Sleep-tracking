//
//  UIDate+Utility.swift
//  Sleep Tracking Demo
//
//  Created by Vishnu Agarwal on 18/06/19.
//  Copyright © 2019 Vishnu Agarwal. All rights reserved.
//

import UIKit

extension Date {
    static let time: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter
    }()
    static let monthDay: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd"
        return dateFormatter
    }()
    var convertDateToMonthDay: String {
        let dateFormatter = Date.monthDay
        let str = dateFormatter.string(from: self)
        return str
    }
    var convertDateToTime: String {
        let dateFormatter = Date.time
        let str = dateFormatter.string(from: self)
        return str
    }
    func dayOfTheWeek() -> String {
        let weekdays = [
            "Sun",
            "Mon",
            "Tue",
            "Wed",
            "Thu",
            "Fri",
            "Sat"
        ]
        let calendar: Calendar = Calendar.current
        let components = calendar.dateComponents([.weekday], from: self)
        return weekdays[(components.weekday ?? 1) - 1]
    }
}
