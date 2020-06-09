
import ObjectMapper
import Alamofire


/// Interface for making API Calls
/// Knows which manager to use for a particular API call
/// TODO:  we should make an interface for different domains of the system and send that particular interface implementor instance to the outside world
/// instead of exposing the whole interface
class NetworkHelper {

    static let shared = NetworkHelper()
    
    private init () { }

    
    func getWheatherData(_ lat: Double, lon: Double, completion: @escaping (Result<WeatherModel>) -> Void) {

        WeatherDetailsNetworkManager().getWheatherData(lat, lon: lon) { result in
            completion(result)
        }
    }
}
