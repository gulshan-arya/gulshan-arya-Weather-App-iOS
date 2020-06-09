
import Foundation


/// Interface used for providing Base Urls and versioning required for different modules e.g realm and for different environment
protocol Spec {
    
    func getBaseStaticImageUrl() -> String
    
    func getBaseAPIUrl() -> String
    
    func getApiKey() -> String
    
    func realmSchemaVersionForMigration() -> Int
    
    func enableClearRealmIfMigrationRequired() -> Bool
}

/// Contains Spec information for Prod environment.
/// We can create spec for different environment like alpha , beta etc.
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



