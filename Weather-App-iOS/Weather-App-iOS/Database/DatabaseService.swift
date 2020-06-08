//
//  DatabaseService.swift
//  PhotoFeeds
//
//  Created by Gulshan on 06/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import UIKit

class DatabaseService: UserDatabase {
    
    private let userDatabase = UserdefaultsDatabase()
    private let cityDatabase = CitiesInfoDBService()
    
    //MARK:- UserDatabase method(s)
    func storeSelectedCity(_ text: String) {
        userDatabase.storeSelectedCity(text)
    }
    
    func fetchUserSelectedCity() -> String? {
        return userDatabase.fetchUserSelectedCity()
    }
    
    func isUserLoggedIn() -> Bool {
        return userDatabase.isUserLoggedIn()
    }
    
    func saveUserLoginDetails(_ userDetails: UserLoginDetails) {
        userDatabase.saveUserLoginDetails(userDetails)
    }
}

extension DatabaseService: CityDatabase {
    
    func findBySearchQuery(_ text: String) -> [CityInfoModel] {
        return cityDatabase.findBySearchQuery(text)
    }
    
    func findByCityId(_ id: String) -> CityInfoModel? {
        return cityDatabase.findByCityId(id)
    }
    
    func isCityDataAvailable() -> Bool {
        return cityDatabase.isCityDataAvailable()
    }
}
