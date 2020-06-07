//
//  LauncherViewRouter.swift
//  Weather-App-iOS
//
//  Created by Gulshan on 08/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import UIKit



class LauncherViewRouter {

    init() {
        
    }
    
    //MARK:- Public method(s)
    func openLoginViewController(from vc: UIViewController) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let rootVC = storyboard.instantiateViewController(identifier: "LoginViewController") as? LoginViewController else {
            return
        }
        
        rootVC.modalPresentationStyle = .fullScreen
        vc.present(rootVC, animated: true)
    }
    
    func openWeatherViewController(from vc: UIViewController) {
        let viewModel = WeatherViewModel(database: UserdefaultsDatabase())
        let rootVC = WeatherViewController(viewModel: viewModel)
        vc.navigationController?.pushViewController(rootVC, animated: true)
    }
}
