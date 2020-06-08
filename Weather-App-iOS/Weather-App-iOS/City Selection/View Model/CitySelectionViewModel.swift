
//
//  Database.swift
//  PhotoFeeds
//
//  Created by Gulshan on 06/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//


import UIKit

protocol CitySelectionViewModelDelegate: class {
    func refreshUI()
    func shouldShowEmptySearchView(_ isHidden: Bool, with text: String)
}

class CitySelectionViewModel {
    
    weak var viewDelegate: CitySelectionViewModelDelegate?
    
    private var database                 : CityDatabase
    private(set) var cities              = [CityInfoModel]()
    
    init(database: CityDatabase) {
        self.database = database
    }
    
    //MARK:- public method(s)
    func viewDidLoad() {
        
        viewDelegate?.shouldShowEmptySearchView(false, with: Constants.defaultSearchMessage)
    }
    
    func searchBar(_ serchBar: UISearchBar, DidChangeText text: String) {
        self.cities = database.findBySearchQuery(text)
        viewDelegate?.refreshUI()
        viewDelegate?.shouldShowEmptySearchView(cities.nonEmpty(), with: Constants.emptySearchMessage)
    }
}

