//
//  WeatherRouter.swift
//  Weather-App-iOS
//
//  Created by Gulshan on 08/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import UIKit

protocol WeatherRouterToViewModelDelegate: class {
    func citySelectionVC(_ vc: CitySelectionViewController, didEndWithSearchResult result: CityInfoModel?)
}

class WeatherRouter {

    weak var delegate: WeatherRouterToViewModelDelegate?
    
    init() {
        
    }
    
    func openCitySelectionScreen(from vc: UIViewController) {
        let viewModel = CitySelectionViewModel(database: CitiesInfoDBService())
        let citySelectionVC = CitySelectionViewController(viewModel: viewModel)
        citySelectionVC.delegate = self
        vc.navigationController?.pushViewController(citySelectionVC, animated: true)
    }
}

extension WeatherRouter: CitySelectionVCDelegateVCDelegate {
    
    func backButtonTapped(in vc: CitySelectionViewController) {
        vc.navigationController?.popViewController(animated: true)
        delegate?.citySelectionVC(vc, didEndWithSearchResult: nil)
    }
    
    func searchLandingVC(_ vc: CitySelectionViewController, didSelectCity city: CityInfoModel) {
        
        vc.navigationController?.popViewController(animated: true)
        delegate?.citySelectionVC(vc, didEndWithSearchResult: city)
    }
}
