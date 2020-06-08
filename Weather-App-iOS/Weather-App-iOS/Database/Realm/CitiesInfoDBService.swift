//
//  CitiesInfoDBService.swift
//  Weather-App-iOS
//
//  Created by Gulshan on 07/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import UIKit
import RealmSwift

class CitiesInfoDBService: DatabaseLike , CityDatabase {
    
    var type: DatabaseType {
        return .realm
    }
    
    static func createOrUpdate() {
        
        let realmDB = RealmManager.instance!.getRealm(RealmDBType.STATIC)
        if let str = FileReader.shared.read(at: FileReadDataSource(filePath: .indianCities, fileType: .csv, bundle: .main)) {
            try! realmDB.write {
                
                let existingModels = realmDB.objects(CityInfoObject.self)
                realmDB.delete(existingModels)
                
                if let cities = try? CityInfoBuilder(citiesDataString: str, country: .india).build() {
                    cities.forEach { cityModel in
                        let reamItem = CityInfoObject()
                        reamItem.name = cityModel.name.uppercased()
                        reamItem.zipcode = cityModel.zipcode
                        reamItem.lat = cityModel.lat
                        reamItem.lon = cityModel.lon
                        reamItem.state = cityModel.state
                        reamItem.country = cityModel.country
                        
                        realmDB.add(reamItem)
                    }
                }
            }
        }
    }
    
    func findBySearchQuery(_ text: String) -> [CityInfoModel] {
        if let realmDB = RealmManager.instance?.getRealm(RealmDBType.STATIC){
            let predicate = NSPredicate(format: "name BEGINSWITH %@ OR zipcode BEGINSWITH %@", text.uppercased(), text)
            let results = realmDB.objects(CityInfoObject.self).filter(predicate)
            return results.map { c in
                CityInfoModel(name: c.name, zipcode: c.zipcode, lat: c.lat, lon: c.lon, state: c.state, country: c.country)
            }
        }
        return []
    }
    
    func isCityDataAvailable() -> Bool {
        var objectCount = 0
        if let realmDB = RealmManager.instance?.getRealm(RealmDBType.STATIC) {
            objectCount = realmDB.objects(CityInfoObject.self).count
        }
        
        return objectCount > 0
    }
}
