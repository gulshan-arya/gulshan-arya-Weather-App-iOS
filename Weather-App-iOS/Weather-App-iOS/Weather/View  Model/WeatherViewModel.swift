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
    
    private var database    : SearchDatabase
    private var weatherModel: WeatherViewModel?
    private var cityData    : CityInfoModel?
    
    // let lat: Double = 76
    
    private var databaseQueue = DispatchQueue(label: "com.gulshan.Weather-App-iOS", qos: .userInitiated, attributes: .concurrent)
    
    init(database: SearchDatabase) {
        self.database = database
    }
    
    //MARK:- Public method(s)
    func viewDidLoad() {
        
        cityData == nil ? fetchWeatherDetails() : fetchWeatherDetails()
    }
    
    //MARK:- Private method(s)
    private func fetchWeatherDetails() {
        
        if let str = FileReader.shared.read(at: FileReadDataSource(filePath: .indianCities, fileType: .csv, bundle: .main)) {
            let result = try? CityInfoBuilder(citiesDataString: str, country: .india).build()
            
            let pehowa = result?.first( where: {  $0.name == "Pehowa" })
            
            NetworkHelper.shared.getWheatherData(pehowa!.lat, lon: pehowa!.lon) { result in
                
                switch result.isSuccess {
                case true :
                    if let cityWeather = result.value, cityWeather.isValid() {
                        
                    } else {
                        
                    }
                case false:  print("")
                }
            }
        }
    }
}
