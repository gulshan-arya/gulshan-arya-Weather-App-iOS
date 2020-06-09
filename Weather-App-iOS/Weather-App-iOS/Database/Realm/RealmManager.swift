//
//  RealmManager.swift
//  Weather-App-iOS
//
//  Created by Gulshan on 07/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//
import Foundation
import RealmSwift

/// Handles creation and deletion of realm instance and storage.
class RealmManager {
    
    static var instance: RealmManager?
    
    var staticRealm: Realm?
    var userRealm: Realm? //TODO: Remove this, not getting used.
    
    private init() {}
    
    
    func deleteUserRealmRows(){
        if userRealm != nil {
            userRealm!.beginWrite()
            userRealm?.deleteAll()
            try! userRealm!.commitWrite()
        }
    }
    
    func getRealm(_ dbType: RealmDBType = RealmDBType.STATIC) -> Realm {
        if dbType == RealmDBType.STATIC {
            return staticRealm!
        } else {
            return userRealm!
        }
    }
    
    static func createInstance(){
        instance = RealmManager()
        RealmManager.instance!.createRealm()
    }
    
    private func closeRealm(){
        staticRealm = nil
        userRealm = nil
    }
    
    private func createRealm(){
        if staticRealm == nil {
            staticRealm = RealmDBService.getRealmInstance(RealmDBType.STATIC)
        }
        
        if userRealm == nil {
            userRealm = RealmDBService.getRealmInstance(RealmDBType.USER)
        }
    }
    static func closeInstance(){
        RealmManager.instance?.closeRealm()
        self.instance = nil
    }
}
