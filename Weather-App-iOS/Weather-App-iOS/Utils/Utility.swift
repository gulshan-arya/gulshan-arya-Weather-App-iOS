//
//  Utility.swift
//  Weather-App-iOS
//
//  Created by Gulshan on 07/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import UIKit

protocol Temprature {
    var value: Double { get set }
    var string: String { get }
}

struct Kelvin: Temprature {
    var value: Double
    var string: String {
        return String(format: "%.0f", value)
    }
}

struct Celsius: Temprature {
    var value: Double
    var string: String {
        return String(format: "%.0f", value)
    }
    
    init(value: Double) {
        self.value = value
    }
    
    init(kelvin: Kelvin) {
        self.value = kelvin.value - 273.15
    }
}

class Utility {

    static let shared = Utility()
    
    private init() {}
    
    func convertKelvinToCelsiusString(_ kelvinTemp: Kelvin) -> String {
        return Celsius(kelvin: kelvinTemp).string
    }
    
    func getDateString(_ seconds: Int) -> String {
        let dateVar = Date.init(timeIntervalSince1970: TimeInterval(seconds * 1000))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy hh:mm"
        return dateFormatter.string(from: dateVar)
    }
}

