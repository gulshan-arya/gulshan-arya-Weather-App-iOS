//
//  BiometricErrorMessages.swift
//  Weather-App-iOS
//
//  Created by Gulshan on 05/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import Foundation
import LocalAuthentication

class BiometricErrorMessages {
    
    static let shared = BiometricErrorMessages()
    
    let touchIdNotAvailable = "Touch id is not available"
    
    private let authenticationFailed = "There was a problem verifying your identity."
    private let userPressedCancel = "You pressed cancel"
    private let passcodePressed = "You pressed password"
    private let biometryNotAvailable = "Face ID/Touch ID is not available"
    private let biometryNotEnrolled = "Face ID/Touch ID is not set up"
    private let biometryLockout = "Face ID/Touch ID is locked"
    private let touchIdNotConfigured = "Face ID/Touch ID may not be configured"
    
    private init() { }
    
    
    func getErrorMessage(_ error: Error?) ->  String {
        
        switch error {
            
        case LAError.authenticationFailed?: return authenticationFailed
            
        case LAError.userCancel?: return userPressedCancel
            
        case LAError.userFallback?: return passcodePressed
            
        case LAError.biometryNotAvailable?: return biometryNotAvailable
            
        case LAError.biometryNotEnrolled?: return biometryNotEnrolled
            
        case LAError.biometryLockout?: return biometryLockout
            
        default: return touchIdNotConfigured
        
        }
    }
    
}
