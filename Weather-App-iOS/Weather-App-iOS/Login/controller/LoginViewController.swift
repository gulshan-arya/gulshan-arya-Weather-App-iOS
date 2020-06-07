//
//  LoginViewController.swift
//  Weather-App-iOS
//
//  Created by Gulshan on 05/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import UIKit
import CoreData

struct KeychainConfiguration {
    static let serviceName = "TouchMeIn"
    static let accessGroup: String? = nil
}

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    var passwordItems: [KeychainPasswordItem] = []
    let touchMe = BiometricIDAuth()
    var managedObjectContext: NSManagedObjectContext?
    
    // MARK: - IBOutlets
    @IBOutlet weak var loginButton      : UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var createInfoLabel  : UILabel!
    @IBOutlet weak var touchIDButton    : UIButton!
    @IBOutlet weak var fbLoginButton    : UIControl!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let hasLogin = UserDefaults.standard.bool(forKey: "hasLoginKey")
        
        loginButton.setTitle("Login/Signup", for: .normal)
        createInfoLabel.isHidden = true
        loginButton.setTitle("Login/Signup", for: .normal)
        createInfoLabel.isHidden = false
        
        if let storedUsername = UserDefaults.standard.value(forKey: "username") as? String {
            usernameTextField.text = storedUsername
        }
        
        //touchIDButton.isHidden = !touchMe.canEvaluatePolicy()
        
//        switch touchMe.getBioMetrictype() {
//        case .touchID:
//            touchIDButton.setImage(UIImage(named: "Touch-icon-lg"),  for: .normal)
//        default: touchIDButton.isHidden = true
//            
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let touchBool = touchMe.canEvaluatePolicy()
        if touchBool {
            self.touchIDLoginAction()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Action for checking username/password
    @IBAction func loginAction(sender: UIButton) {
        
        guard let newAccountName = usernameTextField.text,
            let newPassword = passwordTextField.text,
            !newAccountName.isEmpty,
            !newPassword.isEmpty else {
                showLoginFailedAlert()
                return
        }
        
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        let hasLoginKey = UserDefaults.standard.bool(forKey: "hasLoginKey")
        if !hasLoginKey && usernameTextField.hasText {
            UserDefaults.standard.setValue(usernameTextField.text, forKey: "username")
        }
        
        openWeatherController()
        
        //
        //            do {
        //
        //                // This is a new account, create a new keychain item with the account name.
        //                let _ = KeychainPasswordItem(service: KeychainConfiguration.serviceName,
        //                                             account: newAccountName,
        //                                             accessGroup: KeychainConfiguration.accessGroup)
        //
        //                // Save the password for the new item.
        //                try passwordItem.savePassword(newPassword)
        //            } catch {
        //                fatalError("Error updating keychain - \(error)")
        //            }
        
        
    }
    
    @IBAction private func fbLoginButtonAction(_ sender: Any) {
        
//        if !ZLFacebookLoginService.instance.isUserLoggedInToFB() {
//            ZLFacebookLoginService.instance.performFbLogin(self) { (error) in
//                if error == nil {
//                    // Save token to db
//                    self.openWeatherController()
//                }
//            }
//        }
        
        openWeatherController()
    }
    
    
    @IBAction private func touchIDLoginAction() {
        touchMe.authenticateUser() { [weak self] message in
            if let message = message {
                // if the completion is not nil show an alert
                let alertView = UIAlertController(title: "Error",
                                                  message: message,
                                                  preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Darn!", style: .default)
                alertView.addAction(okAction)
                self?.present(alertView, animated: true)
                
            } else {
                self?.openWeatherController()
            }
        }
    }
    
    private func checkLogin(username: String, password: String) -> Bool {
        guard username == UserDefaults.standard.value(forKey: "username") as? String else {
            return false
        }
        
        //    do {
        //      let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName,
        //                                              account: username,
        //                                              accessGroup: KeychainConfiguration.accessGroup)
        //      let keychainPassword = try passwordItem.readPassword()
        //      return password == keychainPassword
        //    }
        //    catch {
        //      fatalError("Error reading password from keychain - \(error)")
        //    }
        return false
    }
    
    private func showLoginFailedAlert() {
        let alertView = UIAlertController(title: "Login Problem",
                                          message: "Wrong username or password.",
                                          preferredStyle:. alert)
        let okAction = UIAlertAction(title: "Foiled Again!", style: .default)
        alertView.addAction(okAction)
        present(alertView, animated: true)
    }
    
    private func openWeatherController() {
        
        let viewModel = WeatherViewModel(database: UserdefaultsDatabase())
        let vc = WeatherViewController(viewModel: viewModel)
        navigationController?.pushViewController(vc, animated: true)
    }
}

