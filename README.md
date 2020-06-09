# Weather-App-iOS

---
This project provides weather information for the cities of US and India. Weather-App-iOS uses the OpenWeatherMap API to show weather data
it supports login via username and password, facebook and using touchId. The Architecture is based on MVVM with some extra component addition like router 
for routing to different screens.

With Weather-App-iOS you can:

- See current weather information for selected city of US and India
- Detailed weather information is offered in addition to the overviews
- Do login via Facebook and TouchId

## Architecture
The app uses MVVM based architecture with the additon of router layer which handles the routing from one screen to other. Router of one screen can only talk to 
its view model or other screen view model. But mostly, it gets instructions from its underlying view model for naviagtion.

## Flow 
![Alt text](/flow.png?raw=true "Optional Title")

## Goals of this Project
 
- Programming concepts such as delegation, closures, generics & extensions
- Persisiting data UserDefaults and realm
- Network requests
- Using 3rd party REST-APIs
- Using 3rd party libraries via CocoaPods


## Third party libraries used
- [ObjectMapper](https://github.com/tristanhimmelman/ObjectMapper)
- [Alamofire](https://github.com/Alamofire/Alamofire)
- [SDWebImage](https://github.com/SDWebImage/SDWebImage)
- [RealmSwift](https://github.com/realm/realm-cocoa)
- [FacebookSDK](https://github.com/facebook/facebook-ios-sdk)
