
import ObjectMapper
import Alamofire


class NetworkHelper {

    static let shared = NetworkHelper()
    
    private init () { }

    
    func getWheatherData(_ lat: Double, lon: Double, completion: @escaping (Result<WeatherModel>) -> Void) {

        WeatherDetailManager().getWheatherData(lat, lon: lon) { result in
            completion(result)
        }
    }
}
