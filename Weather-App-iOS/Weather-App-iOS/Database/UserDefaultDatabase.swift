//
//  UserDefaultDatabase.swift
//  PhotoFeeds
//
//  Created by Gulshan on 06/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//


class UserdefaultsDatabase: DatabaseLike, UserDatabase {
    
    var type: DatabaseType {
        return .userDefaults
    }
    
    func storeSelectedCity(_ text: String) {
        
    }
    
    func fetchUserSelectedCity() -> String? {
        return nil
    }
    
    func isUserLoggedIn() -> Bool {
        return true
    }
    
    func saveUserDetails() {
        
    }
    
    //MARK:- Private Method(s)
}
