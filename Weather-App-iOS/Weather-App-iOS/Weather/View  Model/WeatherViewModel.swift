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
    
    private var database    : DatabaseService
    private var router      = WeatherRouter()
    private var cityData    : CityInfoModel?

    private var weatherModel: WeatherModel? {
        didSet {
            if weatherModel != nil && cityData?.name != nil {
                layoutDataSource = WeatherLayoutDataSource(weatherModel: weatherModel!, cityName: cityData!.name)
                delegate?.refreshUI()
                delegate?.shouldHideEmptySearch(true, with: nil)
            }
        }
    }
    
    private(set) var layoutDataSource: WeatherLayoutDataSource?
    
    private var databaseQueue = DispatchQueue(label: "com.gulshan.Weather-App-iOS", qos: .userInitiated, attributes: .concurrent)
    
    init(database: DatabaseService) {
        self.database = database
        router.delegate = self
    }
    
    //MARK:- Public method(s)
    func viewDidLoad() {
        
       setCityDataIfCityNameAvailable()
       fetchWeatherDetails()
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        guard let vc = delegate?.viewController else { return false }
       
        router.openCitySelectionScreen(from: vc)
        return false
    }
    
    //MARK:- Private method(s)
    private func fetchWeatherDetails() {
        
        guard let lat = cityData?.lat, let lon = cityData?.lon else {
            delegate?.shouldHideEmptySearch(false, with: Constants.defaultSearchMessage)
            return
        }
        
        ProgressIndicator.startAnimation()
        NetworkHelper.shared.getWheatherData(lat, lon: lon) { result in
            ProgressIndicator.stopAnimation()
            switch result.isSuccess {
            case true :
                if let cityWeather = result.value, cityWeather.isValid() {
                    self.weatherModel = result.value
                } else {
                    self.delegate?.showErrorWithMessage(NSError.genericError().localizedDescription)
                }
            case false:
                let error = result.error ?? NSError.genericError()
                self.delegate?.showErrorWithMessage(error.localizedDescription)
            }
        }
    }
    
    private func setCityDataIfCityNameAvailable() {
        
        if let city = database.fetchUserSelectedCity() {
            let cityData = database.findBySearchQuery(city).first
            self.cityData = cityData
        }
    }
}

extension WeatherViewModel: WeatherRouterToViewModelDelegate {
    
    func citySelectionVC(_ vc: CitySelectionViewController, didEndWithSearchResult result: CityInfoModel?) {
        if cityData != result && result != nil {
            cityData = result
            database.storeSelectedCity(cityData?.name ?? "")
            fetchWeatherDetails()
        }
    }
}
