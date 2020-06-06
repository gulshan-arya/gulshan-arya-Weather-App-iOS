
import Foundation


protocol Spec {
    
    func getBaseStaticImageUrl() -> String
    
    func getBaseAPIUrl() -> String
    
    func getApiKey() -> String
}

//We can create spec for different environment.
class ProdSpec: Spec {
    
    func getBaseStaticImageUrl() -> String {
        //     http://openweathermap.org/img/wn/10d@2x.png
        return "https://openweathermap.org/weather-conditions#How-to-get-icon-URL"
    }
    
    func getBaseAPIUrl() -> String {
        return "https://api.openweathermap.org/"
    }
    
    func getApiKey() -> String { //rmf3
        return "11-5aa8d384afe4769c566762d5e85249ba"
    }
}



