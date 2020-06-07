//
//  CollectionViewContainerCell.swift
//  Weather-App-iOS
//
//  Created by Gulshan on 07/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import UIKit

class CollectionViewContainerCell: UICollectionViewCell {

    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var hourlyWeatherDataSource: HourlyWeatherDataSource?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        collectionView.register(UINib(nibName: "HourlyWeatherCell", bundle: nil), forCellWithReuseIdentifier: "HourlyWeatherCell")
    }
    
    //MARK:- Public method(s)
    func updateCell(_ hourlyWeather: [CurrentWeatherModel]) {
        hourlyWeatherDataSource = HourlyWeatherDataSource(hourlyWeather: hourlyWeather, delegate: self)
        collectionView.delegate = hourlyWeatherDataSource
        collectionView.dataSource = hourlyWeatherDataSource
    }
}

extension CollectionViewContainerCell: HourlyWeatherDataSourceDelegate {
    
    func didInitializeDataSource(_ dataSource: HourlyWeatherDataSource) {
        collectionView.reloadData()
    }
}
