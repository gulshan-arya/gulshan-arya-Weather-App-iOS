//
//  WeatherViewModel.swift
//  Weather-App-iOS
//
//  Created by Gulshan on 07/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import UIKit

class WeatherViewModel {

    weak var delegate: WeatherViewModelDelegate?
    
    private var database    : UserDatabase
    private var cityData    : CityInfoModel?

    private(set) var weatherModel: WeatherModel?
    
    let lat: Double = 29.97
    let lon: Double = 76.58
    
    private var databaseQueue = DispatchQueue(label: "com.gulshan.Weather-App-iOS", qos: .userInitiated, attributes: .concurrent)
    
    init(database: UserDatabase) {
        self.database = database
    }
    
    //MARK:- Public method(s)
    func viewDidLoad() {
        
        cityData == nil ? fetchWeatherDetails() : fetchWeatherDetails()
        //CitiesInfoDBService.shared.findBySearchQuery("pehowa").first
    }
    
    //MARK:- Private method(s)
    private func fetchWeatherDetails() {
        
        ProgressIndicator.startAnimation()
        NetworkHelper.shared.getWheatherData(lat, lon: lon) { result in
            DispatchQueue.main.async {
                ProgressIndicator.stopAnimation()
                switch result.isSuccess {
                case true :
                    if let cityWeather = result.value, cityWeather.isValid() {
                        self.weatherModel = result.value
                        self.delegate?.refreshUI()
                    } else {
                        self.delegate?.showError() /// invalid city data
                    }
                case false:
                    self.delegate?.showError()
                }
            }
        }
    }
}
