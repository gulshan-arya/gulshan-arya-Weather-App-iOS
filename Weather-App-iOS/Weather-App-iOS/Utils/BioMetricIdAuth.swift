//
//  BioMetricIdAuth.swift
//  Weather-App-iOS
//
//  Created by Gulshan on 05/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//


import Foundation
import LocalAuthentication

enum BiometricType {
  case none
  case FaceId // Not supported for now
  case touchID
}

/// Handles BiometricID Authente
class BiometricIDAuth {
    
    private let context = LAContext()
    private var loginReason = "Logging in with Touch ID"
    
    //MARK:- Public method(s)
    func getBioMetrictype() -> BiometricType {
        let _ = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        switch context.biometryType {
        case .touchID:
            return .touchID
        case .faceID:
            return .none
        case .none:
            return .none
        @unknown default:
            return .none
        }
    }
    
    func canEvaluatePolicy() -> Bool {
        return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
    }
    
    func authenticateUser(completion: @escaping (String?) -> Void) {
       
        guard canEvaluatePolicy() else {
            completion(BiometricErrorMessages.shared.touchIdNotAvailable)
            return
        }
        
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: loginReason) { (isSuccess, evaluateError) in
           
            DispatchQueue.main.async {
                completion(isSuccess ? nil : BiometricErrorMessages.shared.getErrorMessage(evaluateError))
            }
        }
    }
}
