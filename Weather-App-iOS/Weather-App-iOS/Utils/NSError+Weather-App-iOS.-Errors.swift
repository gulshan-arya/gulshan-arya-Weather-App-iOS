//
//  NSError+Weather-App-iOS.-Errors.swift
//  Weather-App-iOS
//
//  Created by Gulshan on 05/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import Foundation


import Foundation

enum ErrorDisplayType {
    case blockingError
    case nonBlocking
}

protocol DisplayableError {
    var errorDisplayType:ErrorDisplayType { get set }
}

extension NSError
{
    enum ErrorModule:String
    {
        case FacebookError = "fb"
        case WebServiceError = "ws"
        
        var description: ErrorModule? {
            switch self.rawValue {
            case "fb": return self
            case "ws": return self
            default: return nil
            }
        }
    }
    
    enum ErrorCodes:Int
    {
        case fbLoginError = 100
        case fbLoginCancelError
        
        case wsNoInternetError = 800
        case wsNetworkError
        case wsAddUserZilingoIdError
        case wsAddUserEmailIdError
        case wsAddUserPhoneError
        case wsForgotPasswordError
    }
    
    static var errorModuleIdentifierKey: String { return "ZLErrorModuleIdentifierKey" }
    
    /**
     Key for value in userinfo that gives the plain english string to be shown as the failureReason for Analytics
     */
    static var errorAnalyticsDescriptionKey: String { return "ZLErrorAnalyticsDescriptionKey" }
    
    
    class func domainString() -> String
    {
        return Bundle.main.bundleIdentifier!
    }
    
    static func userInfoFromModule(_ errorModule:ErrorModule, localizedDescription:String?, localizedReason:String?) -> [String:String] {
        var userInfo = [errorModuleIdentifierKey:errorModule.rawValue]
        
        if let errorDescription = localizedDescription {
            userInfo[NSLocalizedDescriptionKey] = errorDescription
        }
        
        if let errorReason = localizedReason {
            userInfo[NSLocalizedFailureReasonErrorKey] = errorReason
        }
        
        return userInfo
    }
    
    func analyticsDescription() -> String {
        if let description = userInfo[NSError.errorAnalyticsDescriptionKey] as? String {
            return description
        }
        else {
            return localizedDescription
        }
    }
    
    
    //MARK: - Error Factory methods
    static func displayableError(_ errorModule:ErrorModule, code:ErrorCodes, localizedDescription:String?, localizedReason:String?) -> NSError
    {
        let userInfo = userInfoFromModule(errorModule, localizedDescription: localizedDescription, localizedReason: localizedReason)
        let error = NSError(domain: domainString(), code: code.rawValue, userInfo: userInfo)
        return error
    }
    
    static func genericError() -> NSError
    {
        let error = displayableError(.FacebookError,
                                     code: .fbLoginError,
                                     localizedDescription: "Error",
                                     localizedReason: "Could not complete operation")
        return error
    }
    
    static func wsNetworkError() -> NSError {
        
        let errorReason = "Oh no! Something went wrong. Please try again"
        return displayableError(.WebServiceError,
                                code: .wsNetworkError,
                                localizedDescription: errorReason,
                                localizedReason: errorReason)
    }
    
    static func wsNoInternetError() -> NSError {
        
        let noInternetConnection = "No Internet Connection"
        return displayableError(.WebServiceError,
                                code: .wsNoInternetError,
                                localizedDescription: noInternetConnection,
                                localizedReason: noInternetConnection)
    }
    
    static func fbLoginError(_ underlyingError:NSError? = nil) -> NSError{
        
        let facebookLoginErrorMsg = "Couldn't login to Facebook";
        return displayableError(.FacebookError,
                                code: .fbLoginError,
                                localizedDescription: facebookLoginErrorMsg,
                                localizedReason: facebookLoginErrorMsg)
    }
    
    static func alreadyLoggedInLoginError(_ underlyingError:NSError? = nil) -> NSError{
        
        let facebookLoginErrorMsg = "You are already logged in to Facebook";
        return displayableError(.FacebookError,
                                code: .fbLoginError,
                                localizedDescription: facebookLoginErrorMsg,
                                localizedReason: facebookLoginErrorMsg)
    }
    
    static func fbLoginCancelledError() -> NSError{
        
        let facebookLoginErrorMsg = "Facebook login was cancelled";
        return displayableError(.FacebookError,
                                code: .fbLoginCancelError,
                                localizedDescription: facebookLoginErrorMsg,
                                localizedReason: facebookLoginErrorMsg)
    }
}
