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
    
    //MARK:- Public Method(s)
    func fetchData() {
        
        createCityDataIfNeeded()
        launchRequiredScreen()
    }
    
    //MARK:- Private Method(s)
    private func createCityDataIfNeeded() {
        
        DispatchQueue.global(qos: .utility).sync {
            if !self.database.isCityDataAvailable() {
                RealmDatabase.createCityData()
            }
        }
    }
    
    private func launchRequiredScreen() {
        DispatchQueue.main.async {
            self.database.isUserLoggedIn() ? self.moveToWeatherViewController() : self.moveToLoginViewController()
        }
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
