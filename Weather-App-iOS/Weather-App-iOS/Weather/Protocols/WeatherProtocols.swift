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
    func shouldHideEmptySearch(_ shouldShow: Bool, with message: String?)
    func showErrorWithMessage(_ message: String)
}

protocol CitySelectionVCDelegate: class {
    func backButtonPressedInVC(_ vc: UIViewController)
    func seachVCDidEndSeach(_ vc: UIViewController, withText text: String)
}

protocol SearchResultViewModelDelegate: ViewControllable {
    func refreshUI()
    func showError()
    func showHideViews()
}



