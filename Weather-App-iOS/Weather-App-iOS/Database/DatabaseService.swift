//
//  DatabaseService.swift
//  PhotoFeeds
//
//  Created by Gulshan on 06/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import UIKit

/// Acts an interface for querying the underlying database
/// TODO: Make separate layer for providing access to different types of database from the DatabaseService instance and use that instance as an inteface for
/// proviiding the access to the required database only not the whole database
class DatabaseService: UserDatabase {
    
    private let userDatabase = UserdefaultsDatabase()
    private let cityDatabase = RealmDatabase()
    
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
    
    func findByCityNameOrZipCode(_ text: String) -> [CityInfoModel] {
        return cityDatabase.findByCityNameOrZipCode(text)
    }
    
    func findByCityId(_ id: String) -> CityInfoModel? {
        return cityDatabase.findByCityId(id)
    }
    
    func isCityDataAvailable() -> Bool {
        return cityDatabase.isCityDataAvailable()
    }
}
