//
//  CityInfoModel.swift
//  Weather-App-iOS
//
//  Created by Gulshan on 06/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import Foundation

class CityInfoModel {
    
    private(set) var name: String
    private(set) var zipcode: String
    private(set) var lat: Double
    private(set) var lon: Double
    private(set) var state: String
    private(set) var country: String
    
    init(name: String, zipcode: String, lat: Double, lon: Double, state: String, country: String) {
        self.name = name
        self.zipcode = zipcode
        self.lat = lat
        self.lon = lon
        self.state = state
        self.country = country
    }
}
