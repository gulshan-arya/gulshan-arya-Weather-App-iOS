//
//  UserLoginDetails.swift
//  Weather-App-iOS
//
//  Created by Gulshan on 08/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import UIKit

enum LoginType: String {
    case touchId
    case emailAndPassword
    case fbLogin
}

struct UserLoginDetails: Codable {
    let loginType : LoginType.RawValue
    let isLoggedIn: Bool
    private(set) var username: String?
    private(set) var password: String?
}


