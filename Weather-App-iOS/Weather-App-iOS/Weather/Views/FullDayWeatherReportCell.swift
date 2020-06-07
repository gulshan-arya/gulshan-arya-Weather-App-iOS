//
//  FullDayWeatherReportCell.swift
//  Weather-App-iOS
//
//  Created by Gulshan on 07/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import UIKit

class FullDayWeatherReportCell: UICollectionViewCell {

    @IBOutlet private weak var titlelabel   : UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK:- Public method(s)
    func updateCell(with title: String, and subTitle: String) {
        titlelabel.text = title
        subtitleLabel.text = subTitle
    }
}
