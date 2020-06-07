//
//  HourlyWeatherCell.swift
//  Weather-App-iOS
//
//  Created by Gulshan on 07/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import UIKit

class HourlyWeatherCell: UICollectionViewCell {

    @IBOutlet private weak var tempratureLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var weatherLabel: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
