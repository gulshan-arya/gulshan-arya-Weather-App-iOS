//
//  LauncherViewController.swift
//  Weather-App-iOS
//
//  Created by Gulshan on 07/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import UIKit

class LauncherViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let rootVC = storyboard.instantiateViewController(identifier: "LoginViewController") as? LoginViewController else {
            return
        }
        
        let rootNC = UINavigationController(rootViewController: rootVC)
        rootNC.setNavigationBarHidden(true, animated: true)
        rootNC.modalPresentationStyle = .fullScreen
        present(rootNC, animated: true)
    }
}
