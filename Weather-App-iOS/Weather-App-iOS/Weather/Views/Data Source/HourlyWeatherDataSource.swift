//
//  HourlyWeatherDataSource.swift
//  Weather-App-iOS
//
//  Created by Gulshan on 07/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import UIKit

protocol HourlyWeatherDataSourceDelegate: class {
    func didInitializeDataSource(_ dataSource: HourlyWeatherDataSource)
}

class HourlyWeatherDataSource: NSObject {

    private var hourlyWeather: [CurrentWeatherModel]
    
    weak var delegate: HourlyWeatherDataSourceDelegate?
    
    init(hourlyWeather: [CurrentWeatherModel], delegate: HourlyWeatherDataSourceDelegate) {
        self.hourlyWeather = hourlyWeather
        super.init()
        
        self.delegate = delegate
        delegate.didInitializeDataSource(self)
    }
}

extension HourlyWeatherDataSource: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourlyWeather.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        return hourlyWeather.nonEmpty() ? CGSize(width: width/3, height: 200) : .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let weatherCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourlyWeatherCell", for: indexPath) as! HourlyWeatherCell
        weatherCell.updateCell(hourlyWeather[indexPath.row])
        return weatherCell
    }
}
