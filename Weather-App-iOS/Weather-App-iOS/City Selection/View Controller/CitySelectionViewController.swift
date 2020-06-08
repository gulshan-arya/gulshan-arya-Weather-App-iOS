//
//  CitySelectionViewController.swift
//
//  Created by Gulshan on 06/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import UIKit

protocol CitySelectionVCDelegateVCDelegate: class {
    func backButtonTapped(in vc: CitySelectionViewController)
    func searchLandingVC(_ vc: CitySelectionViewController, didSelectCity city: CityInfoModel)
}

class CitySelectionViewController: UIViewController {
    
    @IBOutlet private weak var searchBar                : UISearchBar!
    @IBOutlet private weak var tableView                : UITableView!
    @IBOutlet private weak var emptySearchView          : UIView!
    @IBOutlet private weak var searchDescriptionLabel   : UILabel!
    
    weak var delegate: CitySelectionVCDelegateVCDelegate?
    
    private let viewModel           :  CitySelectionViewModel
    private let seachLandingNibName = "CitySelectionViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        searchBar.placeholder = Constants.citySearchPlaceholder
        viewModel.viewDidLoad()
        setupTableView()
    }
   
    //MARK:- Init method(s)
    init(viewModel: CitySelectionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: seachLandingNibName, bundle: nil)
        self.viewModel.viewDelegate = self
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
    
    @IBAction private func backButtonAction(_ sender: Any) {
        delegate?.backButtonTapped(in: self)
    }
}

extension CitySelectionViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.cities.isEmpty ? nil : "Select your City" //TODO: Take this message from outside
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         return viewModel.cities.isEmpty ? 0 : 30
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchSuggestionCell.id, for: indexPath) as! SearchSuggestionCell
        cell.titleLabel.text = viewModel.cities[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.searchLandingVC(self, didSelectCity: viewModel.cities[indexPath.row])
    }
}

extension CitySelectionViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
         viewModel.searchBar(searchBar, DidChangeText: searchText)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        viewModel.searchBar(searchBar, DidChangeText: searchBar.text ?? "")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension CitySelectionViewController: CitySelectionViewModelDelegate {
    
    func refreshUI() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func shouldShowEmptySearchView(_ isHidden: Bool, with text: String) { //TODO: take param from view model
        DispatchQueue.main.async {
            let alpha: CGFloat = isHidden ? 0 : 1
            UIView.animate(withDuration: 0.4, animations: {
                self.emptySearchView.alpha = alpha
                self.emptySearchView.isHidden = isHidden
                self.searchDescriptionLabel.text = text
            })
        }
    }
}
