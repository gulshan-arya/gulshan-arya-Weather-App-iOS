//
//  HourlyWeatherCell.swift
//  Weather-App-iOS
//
//  Created by Gulshan on 07/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import UIKit

class HourlyWeatherCell: UICollectionViewCell {

    @IBOutlet private weak var tempratureLabel  : UILabel!
    @IBOutlet private weak var imageView        : UIImageView!
    @IBOutlet private weak var weatherLabel     : UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        tempratureLabel.text = nil
        weatherLabel.text = nil
    }
    
    //MARK:- Public method(s)
    func updateCell(_ weatherModel: CurrentWeatherModel) {
               
        if let temp = weatherModel.currentTemprature {
            tempratureLabel.text = Utility.shared.convertKelvinToCelsiusString(Kelvin(value: temp))
        }
        if let weather = weatherModel.weatherDescription?.first {
            weatherLabel.text = weather.main
            if let str = weather.icon, let image = UIImage(named: str) {
               imageView.image = image
            } else {
               imageView.image = UIImage(named: "01d")!
            }
        }
    }
}
