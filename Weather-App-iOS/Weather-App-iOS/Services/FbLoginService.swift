//
//  FbLoginService.swift
//  Weather-App-iOS
//
//  Created by Gulshan on 05/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import Foundation
import FBSDKLoginKit

class ZLFacebookLoginService {
    
    static let instance = ZLFacebookLoginService()
    
    private init() { }
        
    //MARK:- Public API(s)
    func performFbLogin(_ fromVC: UIViewController ,_ completion:@escaping (_ error: NSError?) -> Void) {
        
        if !isUserLoggedInToFB() {
            loginToFacebook(fromVC, completion: completion)
        }
    }
    
    func isUserLoggedInToFB() -> Bool {
        
        if let fbAccessToken = AccessToken.current, !fbAccessToken.isExpired  {
            return true
        }
        
        return false
    }
    
    //MARK:- Private Method(s)
    private func loginToFacebook(_ fromVC: UIViewController, completion:@escaping (NSError?) -> Void) {
        
        let fbSDKLoginManager = LoginManager()
        let readPermissions = ["public_profile","email"]
        
        fbSDKLoginManager.logIn(permissions: readPermissions, from: fromVC) { (response, _error) in
            
            if let error = _error {
                completion(NSError.fbLoginError(error as NSError))
            }
            else if response != nil && response!.isCancelled {
                
                completion(NSError.fbLoginCancelledError())
            }
            else {
                print("successfully logged in to facebook")
                completion(nil)
            }
        }
    }
}