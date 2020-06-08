//
//  Extensions.swift
//  Weather-App-iOS
//
//  Created by Gulshan on 07/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import Foundation


extension Collection {
    
    func nonEmpty() -> Bool {
        return !self.isEmpty
    }
}

typealias UnixTime = Int
extension UnixTime {
    private func formatType(form: String) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = form
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter
    }
    var dateFull: Date {
        return Date(timeIntervalSince1970: Double(self))
    }
    
    var toHourOnly: String {
        return formatType(form: "HH").string(from: dateFull)
    }
    
    var toHour: String {
        return formatType(form: "HH:mm").string(from: dateFull)
    }
}


extension Date {
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }

    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }
}
