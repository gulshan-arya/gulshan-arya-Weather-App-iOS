//
//  CollectionLayoutDataSource.swift
//  Weather-App-iOS
//
//  Created by Gulshan on 08/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import UIKit

protocol ViewDataSource {
    var numberOfItems: Int { get }
    var size: CGSize { get }
}

struct WeatherLayoutDataSource {
 
    private(set) var sections = [ViewDataSource]()
    
    init(weatherModel: WeatherModel, cityName: String) {
        
        if let cw = weatherModel.current {
            if let temp = cw.currentTemprature, let weather = cw.weatherDescription?.first?.main {
                let t = Utility.shared.convertKelvinToCelsiusString(Kelvin(value: temp))
                sections.append(CurrentWeatherViewDataSource(city: cityName, temprature: t, weather: weather))
            }
        }
        
        if let hw = weatherModel.hourly {
            sections.append(HourWiseWeatherViewDataSource(hourlyWeather: hw))
        }
        
        if let cw = weatherModel.current {
            sections.append(FullWeatherViewDataSource(currentWeather: cw))
        }
    }
}

struct CurrentWeatherViewDataSource: ViewDataSource {
    
    let city      : String
    let temprature: String
    let weather   : String
    
    var size: CGSize {
        let width = UIScreen.main.bounds.width
        return CGSize(width: width, height: 200)
    }
    
    var numberOfItems: Int {
        return 0
    }
}

struct HourWiseWeatherViewDataSource: ViewDataSource {
    
    var size: CGSize {
        let width = UIScreen.main.bounds.width
        return CGSize(width: width, height: 150)
    }
    
    var numberOfItems: Int {
        return items.count
    }
    
    private(set) var items = [HourlyWeatherViewDataSource]()
    private(set) var scrollDirection = UICollectionView.ScrollDirection.horizontal
    
    init(hourlyWeather: [CurrentWeatherModel]) {
        
        items = hourlyWeather.compactMap { data in
            HourlyWeatherViewDataSource(weatherModel: data)
        }
    }
}

struct HourlyWeatherViewDataSource: ViewDataSource {
    
    private(set) var currentTemprature: String!
    private(set) var time: String!
    private(set) var image: UIImage
    
    var size: CGSize {
        let width = UIScreen.main.bounds.width
        return CGSize(width: width/3, height: 150)
    }
    
    var numberOfItems: Int {
        return 0
    }
    
    init?(weatherModel: CurrentWeatherModel) {
        
        if let temp = weatherModel.currentTemprature {
            currentTemprature = Utility.shared.convertKelvinToCelsiusString(Kelvin(value: temp))
        }
        
        time = weatherModel.currentTime?.toHourOnly
        image = UIImage(named: "01d")!
        if let weather = weatherModel.weatherDescription?.first {
            if let str = weather.icon, let image = UIImage(named: str) {
                self.image = image
            }
        }
        
        if currentTemprature == nil || time == nil {
            return nil
        }
    }
}

struct FullWeatherViewDataSource: ViewDataSource {
    
    var size: CGSize {
        return _size
    }
    
    var numberOfItems: Int {
        return rows.count
    }
    
    private var _size: CGSize
    private(set) var scrollDirection = UICollectionView.ScrollDirection.horizontal
    private(set) var rows = [WeatherParamsDataSource]()
    
    init(currentWeather: CurrentWeatherModel) {
        
        if let time = currentWeather.currentTime {
            rows.append(WeatherParamsDataSource(title: "Time", subtitle: time.toHour))
        }
        
        if let time = currentWeather.sunset {
            rows.append(WeatherParamsDataSource(title: "Sunset", subtitle: time.toHour))
        }
        
        if let time = currentWeather.sunrise {
            rows.append(WeatherParamsDataSource(title: "Sunrise", subtitle: time.toHour))
        }
    
        if let pressure = currentWeather.pressure {
            rows.append(WeatherParamsDataSource(title: "Pressure", subtitle: "\(pressure) hPa"))
        }
        
        if let humidity = currentWeather.humidity {
            rows.append(WeatherParamsDataSource(title: "Humidity", subtitle: "\(humidity) %"))
        }
        
        if let windSpeed = currentWeather.windSpeed {
            rows.append(WeatherParamsDataSource(title: "Wind Speed", subtitle: "\(windSpeed) m\\s"))
        }
        
        let count = rows.count % 2 == 0 ? rows.count / 2 : rows.count / 2 + 1
        _size = CGSize(width: UIScreen.main.bounds.width, height: CGFloat(count * 80))
    }
}

struct WeatherParamsDataSource: ViewDataSource {
    
    var size: CGSize {
        let width = UIScreen.main.bounds.width / 2
        return CGSize(width: width, height: 80)
    }
    
    var numberOfItems: Int {
        return 0
    }
    
     let title: String
     let subtitle: String
}
