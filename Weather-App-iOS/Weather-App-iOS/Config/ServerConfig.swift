

import Foundation


struct ServerConfig {

    static private let BASE_URL = SpecProvider.currentSpec.getBaseAPIUrl()
    static let API_KEY = SpecProvider.currentSpec.getApiKey()

    static let WEATHER_MAP_ONE_CALL = BASE_URL + "data/2.5/onecall"
}
