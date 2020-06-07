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
   
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cityLabel.text = "Pehowa"
        weatherLabel.text = "Sunny"
        currentTemprature.text = "21\(degreeUnicode)"
    }
    
    //MARK:- Public method(s)
    func updateCell(_ weatherModel: CurrentWeatherModel) {
        
        let temp = Utility.shared.convertKelvinToCelsiusString(Kelvin(value: weatherModel.currentTemprature!))
        currentTemprature.text = "\(temp)\(degreeUnicode)"
        weatherLabel.text = weatherModel.weatherDescription?.first?.main        
    }
}
