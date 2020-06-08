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
    @IBOutlet private weak var searchBar     : UISearchBar!
    @IBOutlet private weak var emptySearchView: UIView!
    @IBOutlet private weak var searchDescriptionLabel: UILabel!
    
    private var viewModel: WeatherViewModel!
    static var id: String {
        return "WeatherViewController"
    }
    
    //MARK:- Init Method(s)
    init(viewModel: WeatherViewModel) {
        super.init(nibName: WeatherViewController.id, bundle: nil)
        self.viewModel = viewModel
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Overriden Method(s)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        searchBar.placeholder = Constants.citySearchPlaceholder
        viewModel.viewDidLoad()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
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
        return (viewModel?.layoutDataSource?.sections.count) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.layoutDataSource == nil ? 0 : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let sections = viewModel.layoutDataSource?.sections {
            return sections[indexPath.section].size
        }
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath)
        if let sections = viewModel.layoutDataSource?.sections {
            let section = sections[indexPath.section]
            switch section {
            case is CurrentWeatherViewDataSource:
                let weatherCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrentWeatherCell", for: indexPath) as! CurrentWeatherCell
                weatherCell.updateCell(section as! CurrentWeatherViewDataSource)
                return weatherCell
                
            case is HourWiseWeatherViewDataSource:
                let weatherCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewContainerCell", for: indexPath) as! CollectionViewContainerCell
                weatherCell.updateCell(section as! HourWiseWeatherViewDataSource)
                return weatherCell
            case is FullWeatherViewDataSource:
                let weatherCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewContainerCell", for: indexPath) as! CollectionViewContainerCell
                weatherCell.updateCell(section as! FullWeatherViewDataSource)
                return weatherCell
                
            default: return cell
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
    
    func shouldHideEmptySearch(_ shouldHide: Bool, with message: String?) {
        DispatchQueue.main.async {
            let alpha: CGFloat = shouldHide ? 0 : 1
            UIView.animate(withDuration: 0.4, animations: {
                self.emptySearchView.alpha = alpha
                self.emptySearchView.isHidden = shouldHide
                self.searchDescriptionLabel.text = message
            })
        }
    }
    
    func showErrorWithMessage(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
}

extension WeatherViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return viewModel.searchBarShouldBeginEditing(searchBar)
    }
}

