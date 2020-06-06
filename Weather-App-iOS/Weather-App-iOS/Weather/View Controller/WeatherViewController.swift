//
//  WeatherViewController.swift
//  Weather-App-iOS
//
//  Created by Gulshan on 06/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    static var id: String {
        return "WeatherViewController"
    }
    
    //MARK:- Overriden Method(s)
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK:- Init Method(s)
    init() {
        super.init(nibName: WeatherViewController.id, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   //MARK:- Public Method(s)
    
    
}
