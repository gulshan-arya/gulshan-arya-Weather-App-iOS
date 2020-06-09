//
//  CollectionLayoutDataSource.swift
//  Weather-App-iOS
//
//  Created by Gulshan on 08/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import UIKit

/// Should be used by collection view only
protocol CollectionViewDataSource {
    var numberOfItems: Int { get }
    var size: CGSize { get }
}

extension CollectionViewDataSource {
    var numberOfItems: Int { // For Containers views who do not have nested collection view.
        return 0
    }
}

/// Contains the view data source required for weatehr view
struct WeatherLayoutDataSource {
 
    private(set) var sections = [CollectionViewDataSource]()
    
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

struct CurrentWeatherViewDataSource: CollectionViewDataSource {
    
    let city      : String
    let temprature: String
    let weather   : String
    
    var size: CGSize {
        let width = UIScreen.main.bounds.width
        return CGSize(width: width, height: 200)
    }
}

struct HourWiseWeatherViewDataSource: CollectionViewDataSource {
    
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

struct HourlyWeatherViewDataSource: CollectionViewDataSource {
    
    private(set) var currentTemprature: String!
    private(set) var time: String!
    private(set) var image: UIImage
    
    var size: CGSize {
        let width = UIScreen.main.bounds.width
        return CGSize(width: width/3, height: 150)
    }
    
    init?(weatherModel: CurrentWeatherModel) {
        
        if let temp = weatherModel.currentTemprature {
            currentTemprature = Utility.shared.convertKelvinToCelsiusString(Kelvin(value: temp))
        }
        
        time = weatherModel.currentTime?.toHour
        image = UIImage(named: "01d")!
        if let weather = weatherModel.weatherDescription?.first {
            if let str = weather.icon, let image = UIImage(named: str) {
                self.image = image
            }
        }
        
       
        if currentTemprature == nil || time == nil {
            return nil
        }
        
        let calendar = Calendar.current
        let endTime = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: Date())
        let oneThirdDate = calendar.date(byAdding: .hour, value: 8, to: Date())
        
        guard let t = weatherModel.currentTime, let e = endTime, let oneThird = oneThirdDate else { return nil }
        guard e.timeIntervalSince1970 > TimeInterval(t) else { return nil }
        guard oneThird.timeIntervalSince1970 > TimeInterval(t) else { return nil }
    }
}

struct FullWeatherViewDataSource: CollectionViewDataSource {
    
    var size: CGSize {
        return _size
    }
    
    var numberOfItems: Int {
        return rows.count
    }
    
    private(set) var scrollDirection = UICollectionView.ScrollDirection.horizontal
    private(set) var rows = [WeatherParamsDataSource]()
    
    private var _size: CGSize
    
    init(currentWeather: CurrentWeatherModel) {
        
        if let time = currentWeather.currentTime {
            rows.append(WeatherParamsDataSource(title: "Time", subtitle: time.toHour)) ///Store the string constants in some file
        }
        
        if let time = currentWeather.sunset {
            rows.append(WeatherParamsDataSource(title: "Sunset", subtitle: time.toHour))
        }
        
        if let time = currentWeather.sunrise {
            rows.append(WeatherParamsDataSource(title: "Sunrise", subtitle: time.toHour))
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

struct WeatherParamsDataSource: CollectionViewDataSource {
    
    var size: CGSize {
        let width = UIScreen.main.bounds.width / 2
        return CGSize(width: width, height: 80)
    }
    
     let title: String
     let subtitle: String
}
