//
//  WeatherViewController.swift
//  Weather-App-iOS
//
//  Created by Gulshan on 06/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    enum SectionType: Int, CaseIterable {
        case currentWeather
        case hourlyWeather
        case fullWeather
    }
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var viewModel: WeatherViewModel!
    static var id: String {
        return "WeatherViewController"
    }
    
    //MARK:- Init Method(s)
    init(viewModel: WeatherViewModel) {
        super.init(nibName: WeatherViewController.id, bundle: nil)
        self.viewModel = viewModel
        viewModel.delegate = self
        viewModel.viewDidLoad()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Overriden Method(s)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    //MARK:- Private Method(s)
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "collectionViewCell")
        collectionView.register(UINib(nibName: "CurrentWeatherCell", bundle: nil), forCellWithReuseIdentifier: "CurrentWeatherCell")
        collectionView.register(UINib(nibName: "CollectionViewContainerCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewContainerCell")
    }
}


extension WeatherViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return SectionType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.weatherModel == nil ? 0 : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        if let section = SectionType(rawValue: indexPath.section) {
            switch section {
            case .currentWeather: return CGSize(width: width, height: 300)
            case .hourlyWeather: return CGSize(width: width, height: 200)
            case .fullWeather: return CGSize(width: width, height: 200)
            }
        }
        
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath)
        if let section = SectionType(rawValue: indexPath.section) {
            switch section {
            case .currentWeather:
                let weatherCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrentWeatherCell", for: indexPath) as! CurrentWeatherCell
                weatherCell.updateCell(viewModel!.weatherModel!.current!)
                return weatherCell
                
            case .hourlyWeather:
                let weatherCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewContainerCell", for: indexPath) as! CollectionViewContainerCell
                weatherCell.updateCell(viewModel?.weatherModel?.hourly ?? [])
                return weatherCell
            case .fullWeather:
                return cell

            }
        }
        
        return cell
    }
}

extension WeatherViewController: WeatherViewModelDelegate {
    
    var viewController: UIViewController {
        return self
    }
    
    func refreshUI() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func showError() {
        
    }
    
    func showHideViews() {
        
    }
}
