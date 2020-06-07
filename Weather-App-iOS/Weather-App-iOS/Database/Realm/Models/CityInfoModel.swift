//
//  CityInfoModel.swift
//  Weather-App-iOS
//
//  Created by Gulshan on 07/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import UIKit
import RealmSwift

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


class CityInfoObject: Object {
    
    @objc dynamic var name      : String = ""
    @objc dynamic var zipcode   : String = ""
    @objc dynamic var lat       : Double = 0.0
    @objc dynamic var lon       : Double = 0.0
    @objc dynamic var state     : String = ""
    @objc dynamic var country   : String = ""
}

