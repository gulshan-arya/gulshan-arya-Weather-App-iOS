//
//  LauncherViewController.swift
//  Weather-App-iOS
//
//  Created by Gulshan on 07/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import UIKit

/// Provided the UI requried during App Launch
class LauncherViewController: UIViewController {

    private var viewModel: LauncherViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = LauncherViewModel(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.fetchData()
    }
}

extension LauncherViewController: LauncherViewModelDelegate {
 
    var viewController: UIViewController {
        return self
    }
}
