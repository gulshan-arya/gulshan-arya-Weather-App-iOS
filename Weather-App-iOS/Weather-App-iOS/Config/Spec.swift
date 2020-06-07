
import Foundation


protocol Spec {
    
    func getBaseStaticImageUrl() -> String
    
    func getBaseAPIUrl() -> String
    
    func getApiKey() -> String
    
    func realmSchemaVersionForMigration() -> Int
    
    func enableClearRealmIfMigrationRequired() -> Bool
}

//We can create spec for different environment.
class ProdSpec: Spec {
    
    func getBaseStaticImageUrl() -> String {
        return ""
    }
    
    func getBaseAPIUrl() -> String {
        return "https://api.openweathermap.org/"
    }
    
    func getApiKey() -> String { //rmf3
        return "5aa8d384afe4769c566762d5e85249ba"
    }
    
    func realmSchemaVersionForMigration() -> Int {
        return 1
    }
    
    func enableClearRealmIfMigrationRequired() -> Bool {
        return true
    }
}



