//
//  LauncherViewRouter.swift
//  Weather-App-iOS
//
//  Created by Gulshan on 08/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import UIKit


protocol LauncherViewRouterDelegate: class {
    func loginVCDidSuccesslogin(_ vc: UIViewController)
}


class LauncherViewRouter {
    
    var rootViewController: UINavigationController
    
    init?(rootNVC: UINavigationController?) {
        guard let vc = rootNVC else {
            return nil
        }
        self.rootViewController = vc
    }
    
    //MARK:- Public method(s)
    func openLoginViewController(from vc: UIViewController) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let loginVC = storyboard.instantiateViewController(identifier: "LoginViewController") as? LoginViewController else {
            return
        }
        let viewModel = LoginViewModel(delegate: loginVC)
        viewModel.laucherRouterDelegate = self
        loginVC.viewModel = viewModel
        loginVC.modalPresentationStyle = .fullScreen
        vc.present(loginVC, animated: true)
    }
    
    func openWeatherViewController() {
       
        let viewModel = WeatherViewModel(database: DatabaseService())
        let vc = WeatherViewController(viewModel: viewModel)
        rootViewController.pushViewController(vc, animated: true)
    }
}

extension LauncherViewRouter: LauncherViewRouterDelegate {
    
    func loginVCDidSuccesslogin(_ vc: UIViewController) {
        vc.dismiss(animated: false, completion: {
            self.openWeatherViewController()
        })
    }
}
