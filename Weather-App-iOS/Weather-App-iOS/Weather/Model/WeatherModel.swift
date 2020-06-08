//
//  WeatherModel.swift
//  Weather-App-iOS
//
//  Created by Gulshan on 06/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import UIKit
import ObjectMapper

struct WeatherModel: Mappable, Validator {

    private(set) var lat            : Double?
    private(set) var lon            : Double?
    private(set) var timeZone       : String?
    private(set) var timezoneOffset : Int?
    private(set) var current        : CurrentWeatherModel?
    private(set) var hourly         : [CurrentWeatherModel]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        
        lat              <- map["lat"]
        lon              <- map["lon"]
        timeZone         <- map["timezone"]
        timezoneOffset   <- map["timezone_offset"]
        current          <- map["current"]
        hourly           <- map["hourly"]
      //  daily            <- map["daily"]
    }
    
    func isValid() -> Bool {
        return (current?.isValid() ?? false) && (hourly?.nonEmpty() ?? false)
    }
}

struct CurrentWeatherModel: Mappable, Validator {

    private(set) var currentTime        : Int?
    private(set) var sunrise            : Int?
    private(set) var sunset             : Int?
    private(set) var currentTemprature  : Double?
    private(set) var pressure           : Int?
    private(set) var humidity           : Int?
    private(set) var windSpeed          : Double?
    private(set) var weatherDescription : [WeatherDescriptionModel]?

    init?(map: Map) {

    }
    
    mutating func mapping(map: Map) {
        
        currentTime          <- map["dt"]
        sunrise              <- map["sunrise"]
        sunset               <- map["sunset"]
        currentTemprature    <- map["feels_like"]
        pressure             <- map["pressure"]
        humidity             <- map["humidity"]
        windSpeed            <- map["wind_speed"]
        weatherDescription   <- map["weather"]
    }
    
    func isValid() -> Bool {
        return weatherDescription?.nonEmpty() ?? false
    }
}

struct WeatherDescriptionModel: Mappable {
    
    private(set) var id   : Int?
    private(set) var main : String?
    private(set) var desc : String?
    private(set) var icon : String?

    init?(map: Map) {

    }
    
    mutating func mapping(map: Map) {
        
        id              <- map["id"]
        main            <- map["main"]
        desc            <- map["description"]
        icon            <- map["icon"]
    }
}




