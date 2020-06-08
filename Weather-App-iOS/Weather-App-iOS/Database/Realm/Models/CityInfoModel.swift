//
//  CityInfoModel.swift
//  Weather-App-iOS
//
//  Created by Gulshan on 07/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import UIKit
import RealmSwift

struct CityInfoModel: Equatable  {

    private(set) var id: String
    private(set) var name: String
    private(set) var zipcode: String
    private(set) var lat: Double
    private(set) var lon: Double
    private(set) var state: String
    private(set) var country: String
}


class CityInfoObject: Object {
    
    @objc dynamic var id        : String = ""
    @objc dynamic var name      : String = ""
    @objc dynamic var zipcode   : String = ""
    @objc dynamic var lat       : Double = 0.0
    @objc dynamic var lon       : Double = 0.0
    @objc dynamic var state     : String = ""
    @objc dynamic var country   : String = ""
    

    override static func primaryKey() -> String? {
        return "id"
    }
    
}

