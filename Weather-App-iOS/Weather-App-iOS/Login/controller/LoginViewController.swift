//
//  LoginViewController.swift
//  Weather-App-iOS
//
//  Created by Gulshan on 05/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import UIKit

/// Handles UI required for Login screen
class LoginViewController: UIViewController {
    
    // MARK: - Properties
    var viewModel           : LoginViewModel!
    
    // MARK: - IBOutlets
    @IBOutlet private weak var loginButton      : UIButton!
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var createInfoLabel  : UILabel!
    @IBOutlet private weak var touchIDButton    : UIButton!
    @IBOutlet private weak var touchIdLoginDesc : UILabel!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDidLoad()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    deinit {
        print("deinit called for loginVC")
    }
    
    // MARK: - Action for checking username/password
    @IBAction func loginAction(sender: UIButton) {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        viewModel.viewDidTapLoginWithEmail(usernameTextField.text ?? "", and: passwordTextField.text ?? "")
    }
    
    @IBAction private func fbLoginButtonAction(_ sender: Any) {
        viewModel.viewDidTapFacebookLogin()
    }
    
    @IBAction private func touchIDLoginAction() {
        viewModel.viewDidTapTouchId()
    }
}

extension LoginViewController: LoginViewModelDelegate {
    
    func showAlertWithMessage(_ str: String) {
        let alertView = UIAlertController(title: "Error",
                                          message: str,
                                          preferredStyle:. alert)
        alertView.addAction(UIAlertAction(title: "Dismiss", style: .default))
        present(alertView, animated: true)
    }
    
    func shouldHideTouchIdViews(_ shouldHide: Bool) {
        touchIdLoginDesc.isHidden = shouldHide
        touchIDButton.isHidden = shouldHide
    }
    
    var viewController: UIViewController {
        return self
    }
}
