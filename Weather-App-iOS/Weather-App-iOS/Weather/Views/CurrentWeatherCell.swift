//
//  CurrentWeatherCell.swift
//  Weather-App-iOS
//
//  Created by Gulshan on 07/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import UIKit

class CurrentWeatherCell: UICollectionViewCell {

    @IBOutlet private weak var cityLabel        : UILabel!
    @IBOutlet private weak var weatherLabel     : UILabel!
    @IBOutlet private weak var currentTemprature: UILabel!
   
    private var degreeUnicode = "\u{00B0}"
   
    //MARK:- Public method(s)
    func updateCell(_ dataSource: CurrentWeatherViewDataSource) {
        
        cityLabel.text = dataSource.city
        currentTemprature.text = "\(dataSource.temprature)\(degreeUnicode)"
        weatherLabel.text = dataSource.weather
    }
}
