
import UIKit
import Alamofire
import ObjectMapper

/// Makes actual Network calls using Alamofire
/// For now only support of get request is added
/// Manager classes should subclass from this class.
class NetworkManager {
    
    /// This can be helpful for making our own errors with messages that make more sense than the errors send by the server
    /// subclass should use this method to parse the success or failure response
    func processReponse<T>(response:DataResponse<Any>, isBackgroundRefresh: Bool = false) -> Result<T> {
        
        guard let validResponse = response.response else {
            
            return failure(result: response.result)
        }
        
        switch validResponse.statusCode {
            
        case 200, 201:
            
            if response.result.value == nil {
                
                return failure(result: response.result)
            }
            return success(result: response.result)
            
        case 500...505:
            return failure(result: response.result)
            
        case 401:
            return failure(result: response.result)
            
        default:
            return failure(result: response.result)
        }
    }
    
    func success<T>(result: Result<Any>) -> Result<T> {
        assert(false,"this method must be overriden in sub classes")
        return Result.failure(result.error!)
    }
    
    func failure<T>(result: Result<Any>) -> Result<T> {
        assert(false,"this method must be overriden in sub classes")
        return Result.failure(result.error!)
    }
    
    func getDataFromUrl(_ url: String, parameters: [String:Any]?, completion: @escaping (DataResponse<Any>) -> Void) {
        
        makeGetRequestForUrl(url, type: .get, parameters: parameters) { (response) in
            completion(response)
        }
    }
    
    //MARK: Private Method(s)
    private func makeGetRequestForUrl(_ url: String, type: HTTPMethod, parameters: [String:Any]?, completion: @escaping (DataResponse<Any>) -> Void) {
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default).validate().responseJSON { (response) in
            completion(response)
        }
    }
}
