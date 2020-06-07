
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
    func showHideEmptySearchView()
}

class CitySelectionViewModel {
    
    weak var viewDelegate: CitySelectionViewModelDelegate?
    
    private var database                 : UserDatabase
    private(set) var resultSearchResults = [String]()
    
    init(database: UserDatabase) {
        self.database = database
    }
    
    //MARK:- public method(s)
    func fetchRecentSearches() {
        
        
    }
}

