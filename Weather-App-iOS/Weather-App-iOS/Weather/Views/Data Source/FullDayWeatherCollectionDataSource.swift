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

    weak var delegate: FullDataWeatherCollectionDataSourceDelegate?
    private var weather: FullWeatherViewDataSource
    
    init(fulldayWeather: FullWeatherViewDataSource, delegate: FullDataWeatherCollectionDataSourceDelegate) {
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
        return weather.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return weather.rows[indexPath.row].size
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let weatherCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FullDayWeatherReportCell", for: indexPath) as! FullDayWeatherReportCell
        let ds = weather.rows[indexPath.row]
        weatherCell.updateCell(with: ds.title, and: ds.subtitle)
        return weatherCell
    }
}
