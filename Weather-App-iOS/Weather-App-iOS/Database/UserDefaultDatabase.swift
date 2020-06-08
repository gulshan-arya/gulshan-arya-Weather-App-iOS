//
//  UserDefaultDatabase.swift
//  PhotoFeeds
//
//  Created by Gulshan on 06/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import Foundation

class UserdefaultsDatabase: DatabaseLike, UserDatabase {
   
    var type: DatabaseType {
        return .userDefaults
    }
    
    private var selectedCityKey = "com.gulshan.Weather-App-iOS.userSelectedCity"
    private var userLoginDetailsKey = "com.gulshan.Weather-App-iOS.userLoginDetailsKey"
    
    func storeSelectedCity(_ text: String) {
        if text.nonEmpty() {
            UserDefaults.standard.set(text, forKey: selectedCityKey)
        }
    }
    
    func fetchUserSelectedCity() -> String? {
        guard let result = UserDefaults.standard.value(forKey: selectedCityKey) as? String else {
            return nil
        }
        return result
    }
    
    func isUserLoggedIn() -> Bool {
        if let data = UserDefaults.standard.data(forKey: userLoginDetailsKey) {
            do {
                let loginDetails = try JSONDecoder().decode(UserLoginDetails.self, from: data)
                return loginDetails.isLoggedIn
            } catch {
                print("Unable to Decode Note (\(error))")
            }
        }
        return false
    }
    
    func saveUserLoginDetails(_ userDetails: UserLoginDetails) {
        do {
            let data = try JSONEncoder().encode(userDetails)
            UserDefaults.standard.set(data, forKey: userLoginDetailsKey)
        } catch {
            print("Unable to Encode UserLoginDetails (\(error))")
        }
    }
}
