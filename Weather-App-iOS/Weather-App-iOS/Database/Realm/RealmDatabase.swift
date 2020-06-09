//
//  RealmDatabase.swift
//  Weather-App-iOS
//
//  Created by Gulshan on 07/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import UIKit
import RealmSwift

/// Acts as DB service for City information for now.
/// Takes City information from  csv resources provided and stores them in realm DB
struct RealmDatabase: DatabaseLike, CityDatabase {
    
    var type: DatabaseType {
        return .realm
    }
    
    //MARK:- Public Method(s)
    
    /// Creates fresh city data every time to ensure duplicated data is not created.
    /// First deletes already stored city data and then creates city data .
    /// For now only Indian and US cities data is stored in Realm DB
    static func createCityData() {
        
        deleteCurrentCityData()
        createCityData(.indianCities, country: .india)
        createCityData(.usaCities, country: .us)
    }
    
    //MARK:- CityDatabase Method(s)
    func findByCityNameOrZipCode(_ text: String) -> [CityInfoModel] {
        if let realmDB = RealmManager.instance?.getRealm(RealmDBType.STATIC){
            let predicate = NSPredicate(format: "name BEGINSWITH %@ OR zipcode BEGINSWITH %@", text.uppercased(), text)
            let results = realmDB.objects(CityInfoObject.self).filter(predicate)
            return results.map { c in
                CityInfoModel(id: c.id, name: c.name, zipcode: c.zipcode, lat: c.lat, lon: c.lon, state: c.state, country: c.country)
            }
        }
        return []
    }
    
     func findByCityId(_ id: String) -> CityInfoModel? {
        if let realmDB = RealmManager.instance?.getRealm(RealmDBType.STATIC){
            return realmDB.object(ofType: CityInfoObject.self, forPrimaryKey: id).map { c in
                CityInfoModel(id: c.id, name: c.name, zipcode: c.zipcode, lat: c.lat, lon: c.lon, state: c.state, country: c.country)
            }
        }
        return nil
    }
    
    func isCityDataAvailable() -> Bool {
        var objectCount = 0
        if let realmDB = RealmManager.instance?.getRealm(RealmDBType.STATIC) {
            objectCount = realmDB.objects(CityInfoObject.self).count
        }
        
        return objectCount > 0
    }
    
    //MARK:- Private method(s)
    
    /// 1) Creates city data from the provided resource path and country. You have to make sure that you pass correct country for resource path that you are using
    /// to create city data.
    /// 2) Uses CityInforBuilder inside to create city data from the csv file.
    static private func createCityData(_ filePath: ResourcePath, country: Country) {
        
        let realmDB = RealmManager.instance!.getRealm(RealmDBType.STATIC)
        if let str = FileReader.shared.read(at: FileReadDataSource(filePath: filePath, fileType: .csv, bundle: .main)) {
            try! realmDB.write {
                if let cities = try? CityInfoBuilder(citiesDataString: str, country: country).build() {
                    cities.forEach { cityModel in
                        let reamItem = CityInfoObject()
                        reamItem.id = cityModel.id
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
    
    static private func deleteCurrentCityData() {
        let realmDB = RealmManager.instance!.getRealm(RealmDBType.STATIC)
        try! realmDB.write {
            let existingModels = realmDB.objects(CityInfoObject.self)
            realmDB.delete(existingModels)
        }
    }
}
