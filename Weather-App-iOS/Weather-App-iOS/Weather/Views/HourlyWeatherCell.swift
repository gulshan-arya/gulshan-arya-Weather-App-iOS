//
//  HourlyWeatherCell.swift
//  Weather-App-iOS
//
//  Created by Gulshan on 07/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import UIKit

class HourlyWeatherCell: UICollectionViewCell {

    @IBOutlet private weak var timeLabel        : UILabel!
    @IBOutlet private weak var imageView        : UIImageView!
    @IBOutlet private weak var tempratureLabel  : UILabel!
        
    //MARK:- Public method(s)
    func updateCell(_ dataSource: HourlyWeatherViewDataSource) {
        timeLabel.text = dataSource.time
        tempratureLabel.text = dataSource.currentTemprature
        timeLabel.text = dataSource.time
    }
}
