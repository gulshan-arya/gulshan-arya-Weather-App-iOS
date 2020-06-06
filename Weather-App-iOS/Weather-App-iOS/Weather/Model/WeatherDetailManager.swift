//
//  WeatherDetailManager.swift
//  Weather-App-iOS
//
//  Created by Gulshan on 06/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import Alamofire
import ObjectMapper

class WeatherDetailManager: NetworkManager {
    
    override func success<T>(result: Result<Any>) -> Result<T> {
        
        let storefront = Mapper<WeatherModel>().map(JSONObject: result.value)
        return Result.success(storefront as! T)
    }
    
    override func failure<T>(result: Result<Any>) -> Result<T> {
        
        return result.error != nil ? Result.failure(result.error!) : Result.failure(NSError.genericError())
    }
    
    func getWheatherData(_ lat: Double, lon: Double, completion: @escaping (Result<WeatherModel>) -> Void) {
        
        let url = ServerConfig.WEATHER_MAP_ONE_CALL
        let params = ["appid": ServerConfig.API_KEY,
                      "lat": lat,
                      "lon": lon] as [String : Any]

        self.getDataFromUrl(url, parameters: params) { (response) in
            
            let result = self.processReponse(response: response) as Result<WeatherModel>
            completion(result)
        }
    }
}

