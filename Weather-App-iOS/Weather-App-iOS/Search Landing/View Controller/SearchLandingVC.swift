//
//  SearchLandingVC.swift
//
//  Created by Gulshan on 06/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import UIKit

protocol SearchLandingVCDelegate: class {
    func backButtonTapped(in vc: UIViewController)
    func searchLandingVC(_ vc: UIViewController, didSelectSearchQuery query: String)
}

class SearchLandingVC: UIViewController {
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var emptySearchView: UIView!
    
    weak var delegate: SearchLandingVCDelegate?
    
    private let viewModel           : SearchLandingViewModel
    private let seachLandingNibName = "SearchLandingVC"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        setupTableView()
        viewModel.fetchRecentSearches()
    }
    
    //MARK:- Init method(s)
    init(viewModel: SearchLandingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: seachLandingNibName, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- private method(s)
    private func setupTableView() {
        
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: SearchSuggestionCell.id, bundle: .main), forCellReuseIdentifier: SearchSuggestionCell.id)
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        delegate?.backButtonTapped(in: self)
    }
}

extension SearchLandingVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.resultSearchResults.isEmpty ? nil : "Select from Recent Searches"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         return viewModel.resultSearchResults.isEmpty ? 0 : 30
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.resultSearchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchSuggestionCell.id, for: indexPath) as! SearchSuggestionCell
        cell.titleLabel.text = viewModel.resultSearchResults[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.searchLandingVC(self, didSelectSearchQuery: viewModel.resultSearchResults[indexPath.row])
    }
}

extension SearchLandingVC: UISearchBarDelegate {
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        delegate?.searchLandingVC(self, didSelectSearchQuery: searchBar.text ?? "")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension SearchLandingVC: SearchLandingViewModelDelegate {
    
    func refreshUI() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showHideEmptySearchView() {
        DispatchQueue.main.async {
            self.emptySearchView.isHidden = !self.viewModel.resultSearchResults.isEmpty
        }
    }
}
