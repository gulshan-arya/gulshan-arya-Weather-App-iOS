//
//  Validator.swift
//  Weather-App-iOS
//
//  Created by Gulshan on 07/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

protocol Validator {
    func isValid() -> Bool
}

struct ValidatorUtility: Validator {
    
    let validators: [Validator]
    
    func isValid() -> Bool {
        return validators.nonEmpty() && validators.reduce(true, { $0 && $1.isValid() } )
    }
}

struct EmailValidator: Validator {
    
    let email: String
    func isValid() -> Bool {
        return email.nonEmpty() //TODO: More validation can be added here
    }
}


struct PasswordValidator: Validator {
    let password: String
    func isValid() -> Bool {
        return password.nonEmpty() && password.count > 5
    }
}

