//
//  CityInfoBuilder.swift
//  Weather-App-iOS
//
//  Created by Gulshan on 06/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import Foundation

protocol Builder: class {
    
    associatedtype T
    func build() throws -> T
}

enum CityBuilderError: Error {
    case invalidCityData
}

enum Country: String {
    case india = "India"
    case us = "US"
}

class CityInfoBuilder: Builder {
    
    private var citiesDataString: String
    private var country         : Country
    
    
    init(citiesDataString: String, country: Country) {
        self.country = country
        self.citiesDataString = citiesDataString
    }
    
    func build() throws -> [CityInfoModel] {
        
        var cities = [CityInfoModel]()
        let rows = citiesDataString.components(separatedBy: "\r")
        for row in rows {
            let columns = row.components(separatedBy: ",")
            if let lat = Double(columns[9]), let lon = Double(columns[10]) {
                cities.append(
                    CityInfoModel(
                        name: columns[2],
                        zipcode: columns[1],
                        lat: lat,
                        lon: lon,
                        state: columns[3],
                        country: country.rawValue
                    )
                )
            }
        }
        
        if cities.isEmpty {
           throw CityBuilderError.invalidCityData
        }
        
        return cities
    }
}


