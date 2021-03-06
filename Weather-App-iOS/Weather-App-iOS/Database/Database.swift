//
//  Database.swift
//  PhotoFeeds
//
//  Created by Gulshan on 06/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import Foundation

enum DatabaseType {
    case userDefaults
    case realm
}

protocol DatabaseLike {
    var type: DatabaseType { get }
}

/// Interface for different type of database
protocol Database {
}

protocol UserDatabase: Database {
    
    func storeSelectedCity(_ text: String)
    
    func fetchUserSelectedCity() -> String?
    
    func isUserLoggedIn() -> Bool
    
    func saveUserLoginDetails(_ userDetails: UserLoginDetails)

}

protocol CityDatabase: Database {
    
    func findByCityId(_ id: String) -> CityInfoModel?
    
    func findByCityNameOrZipCode(_ text: String) -> [CityInfoModel]
           
    func isCityDataAvailable() -> Bool
}




