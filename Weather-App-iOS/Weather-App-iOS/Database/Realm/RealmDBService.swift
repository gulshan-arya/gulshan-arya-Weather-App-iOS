//
//  RealmDBService.swift
//  Weather-App-iOS
//
//  Created by Gulshan on 07/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import UIKit
import RealmSwift

enum RealmDBType: String {
    case STATIC = "staticDB"
    case USER   = "userDB"
}

class RealmDBService {
    
    static func getRealmInstance(_ realmDBType: RealmDBType) -> Realm {
        
        let realm = try! Realm(configuration: getRealmConfiguration(realmDBType))
        return realm
    }
    
    static func getRealmConfiguration(_ realmDBType: RealmDBType) -> Realm.Configuration {
        
        let newRealmVersion =  UInt64(SpecProvider.currentSpec.realmSchemaVersionForMigration())
        var config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            schemaVersion: newRealmVersion,
            
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                
                if (oldSchemaVersion < newRealmVersion) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
        })
        
        config.deleteRealmIfMigrationNeeded = SpecProvider.currentSpec.enableClearRealmIfMigrationRequired()
        
        config.fileURL = config.fileURL!
            .deletingLastPathComponent()
            .appendingPathComponent("\(realmDBType.rawValue).realm")
        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config

        return config
    }
}

