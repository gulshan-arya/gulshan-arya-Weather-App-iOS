//
//  LoginViewModel.swift
//  Weather-App-iOS
//
//  Created by Gulshan on 08/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import UIKit


protocol LoginViewModelDelegate: ViewControllable {
    func showAlertWithMessage(_ str: String)
    func shouldHideTouchIdViews(_ shouldHide: Bool)
}

enum LoginError: Error {
    case invalidPassword
    case invalidEmail
    case touchIdInvalid
    case facebookError
}

/// Handles different types of login based on the UI interaction received
/// saves data to offline storage when successful login happens
/// updates the UI
class LoginViewModel {

    weak var delegate: LoginViewModelDelegate?
    
    weak var laucherRouterDelegate: LauncherViewRouterDelegate?
    
    private let biometricIdAuth = BiometricIDAuth()
    private var userDatabase: UserDatabase = DatabaseService()
    
    init(delegate: LoginViewModelDelegate) {
        self.delegate = delegate
    }
    
    func viewDidLoad() {
        if !biometricIdAuth.canEvaluatePolicy() {
            delegate?.shouldHideTouchIdViews(true)
        }
    }
    
    func viewDidTapLoginWithEmail(_ email: String, and password: String) {
        
        loginWithEmail(email, password: password)
    }
    
    func viewDidTapFacebookLogin() {
        guard let vc = delegate?.viewController else {
            return
        }
        
        FacebookLoginService.instance.performFbLogin(vc) { (error) in
            if error == nil {
                self.userDatabase.saveUserLoginDetails(UserLoginDetails(loginType: LoginType.fbLogin.rawValue, isLoggedIn: true))
                self.handleSuccessFullLogin()
            } else {
                self.delegate?.showAlertWithMessage(error!.localizedDescription)
            }
        }
    }
    
    func viewDidTapTouchId() {
        biometricIdAuth.authenticateUser() { [weak self] errorMessage in
            if let msg = errorMessage {
                self?.delegate?.showAlertWithMessage(msg)
            } else {
                self?.userDatabase.saveUserLoginDetails(UserLoginDetails(loginType: LoginType.touchId.rawValue, isLoggedIn: true))
                self?.handleSuccessFullLogin()
            }
        }
    }
    
    //MARK:- Private method(s)
    private func loginWithEmail(_ email: String, password: String) {
        do {
            let isValid = try validatEmail(email, and: password)
            if isValid {
                userDatabase.saveUserLoginDetails(
                    UserLoginDetails(loginType: LoginType.fbLogin.rawValue, isLoggedIn: true, username: email, password: password)
                )
                self.handleSuccessFullLogin()
            }
        } catch LoginError.invalidEmail {
            delegate?.showAlertWithMessage(Constants.invalidEmail)
        } catch LoginError.invalidPassword {
             delegate?.showAlertWithMessage(Constants.invalidPassword)
        } catch let error {
            print(error)
        }
    }
    
    private func validatEmail(_ email: String, and password: String) throws -> Bool {
        let ev = EmailValidator(email: email)
        let pv = PasswordValidator(password: password)
        guard ev.isValid() else { throw LoginError.invalidEmail }
        guard pv.isValid() else { throw LoginError.invalidPassword }
        return true
    }
    
    private func handleSuccessFullLogin() {
        guard let vc = delegate?.viewController else { return }
        laucherRouterDelegate?.loginVCDidSuccesslogin(vc)
    }
}
