//
//  WeatherProtocols.swift
//  Weather-App-iOS
//
//  Created by Gulshan on 07/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import UIKit

protocol ViewControllable: class {
    var viewController: UIViewController { get }
}

protocol WeatherViewModelDelegate: ViewControllable {
    func refreshUI()
    func showError()
    func showHideViews()
}

protocol WeatherViewModelToRouter: class {
    func openSearchScreen(from vc: UIViewController)
}

protocol SearchResultVCDelegate: class {
    func backButtonPressedInVC(_ vc: UIViewController)
    func seachVCDidEndSeach(_ vc: UIViewController, withText text: String)
}

protocol SearchResultViewModelDelegate: ViewControllable {
    func refreshUI()
    func showError()
    func showHideViews()
}



