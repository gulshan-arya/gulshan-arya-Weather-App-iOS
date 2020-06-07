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
    
    private var hourlyWeatherDataSource            : HourlyWeatherDataSource?
    private var fullDayWeatherCollectionDataSource : FullDayWeatherCollectionDataSource?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        collectionView.register(UINib(nibName: "HourlyWeatherCell", bundle: nil), forCellWithReuseIdentifier: "HourlyWeatherCell")
        collectionView.register(UINib(nibName: "FullDayWeatherReportCell", bundle: nil), forCellWithReuseIdentifier: "FullDayWeatherReportCell")
    }
    
    //MARK:- Public method(s)
    func updateCell(_ hourlyWeather: [CurrentWeatherModel]) {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        hourlyWeatherDataSource = HourlyWeatherDataSource(hourlyWeather: hourlyWeather, delegate: self)
        collectionView.delegate = hourlyWeatherDataSource
        collectionView.dataSource = hourlyWeatherDataSource
    }
    
    func updateCell(_ hourlyWeather: CurrentWeatherModel) {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
        }
        fullDayWeatherCollectionDataSource = FullDayWeatherCollectionDataSource(fulldayWeather: hourlyWeather, delegate: self)
        collectionView.delegate = fullDayWeatherCollectionDataSource
        collectionView.dataSource = fullDayWeatherCollectionDataSource
    }
    
}

extension CollectionViewContainerCell: HourlyWeatherDataSourceDelegate, FullDataWeatherCollectionDataSourceDelegate {
    
    func didInitializeDataSource(_ dataSource: HourlyWeatherDataSource) {
        collectionView.reloadData()
    }
    
    func didInitializeDataSource(_ dataSource: FullDayWeatherCollectionDataSource) {
        collectionView.reloadData()
    }
}