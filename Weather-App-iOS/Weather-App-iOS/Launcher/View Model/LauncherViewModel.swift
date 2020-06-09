//
//  LauncherViewModel.swift
//  Weather-App-iOS
//
//  Created by Gulshan on 08/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import UIKit

protocol LauncherViewModelDelegate: ViewControllable {
}

/// Handles interaction with LauncherViewController
/// Stores city data in city database if it is not already stored
/// Uses router to route to different screens based on the user login status
class LauncherViewModel {
    
    private weak var delegate: LauncherViewModelDelegate?
    
    private let database = DatabaseService()
    private var router: LauncherViewRouter?
    
    init(delegate: LauncherViewModelDelegate) {
        self.delegate = delegate
        router = LauncherViewRouter(rootNVC: delegate.viewController.navigationController)
    }
    
    //MARK:- Public method(s)
    func viewDidLoad() {
        
        createCityDataIfNeeded()
        launchRequiredScreen()
    }
    
    //MARK:- Private method(s)
    private func createCityDataIfNeeded() {
        
        DispatchQueue.main.async {
            ProgressIndicator.startAnimation() /// Use activity indicator , it is not looking good
        }
        
        DispatchQueue.global(qos: .utility).sync { /// used sync Intentionally to store data in the background while UI updates can be done on main thred if needed
            if !database.isCityDataAvailable() {
                RealmDatabase.createCityData()
            }
        }
        
        DispatchQueue.main.async {
            ProgressIndicator.stopAnimation()
        }
    }
    
    private func launchRequiredScreen() {
        
        database.isUserLoggedIn() ? moveToWeatherViewController() : moveToLoginViewController()
    }
    
    private func moveToWeatherViewController() {
        guard let route = router else {
            return
        }
        route.openWeatherViewController()
    }
    
    private func moveToLoginViewController() {
        guard let route = router, let vc = delegate?.viewController else {
            return
        }
        route.openLoginViewController(from: vc)
    }
}
