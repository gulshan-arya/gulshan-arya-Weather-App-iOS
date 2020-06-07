//
//  FullDataWeatherCollectionDataSource.swift
//  Weather-App-iOS
//
//  Created by Gulshan on 07/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import UIKit

protocol FullDataWeatherCollectionDataSourceDelegate: class {
    func didInitializeDataSource(_ dataSource: FullDayWeatherCollectionDataSource)
}

class FullDayWeatherCollectionDataSource: NSObject {

    private var weather: CurrentWeatherModel
    
    weak var delegate: FullDataWeatherCollectionDataSourceDelegate?
    
    init(fulldayWeather: CurrentWeatherModel, delegate: FullDataWeatherCollectionDataSourceDelegate) {
        self.weather = fulldayWeather
        super.init()
        
        self.delegate = delegate
        delegate.didInitializeDataSource(self)
    }
}

extension FullDayWeatherCollectionDataSource: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width / 2
        return CGSize(width: width, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let weatherCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FullDayWeatherReportCell", for: indexPath) as! FullDayWeatherReportCell
        weatherCell.updateCell(with: "Wind", and: "21 m/s")
        return weatherCell
    }
}
