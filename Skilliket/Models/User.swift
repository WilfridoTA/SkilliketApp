//
//  User.swift
//  Jsons
//
//  Created by Astrea Polaris on 07/10/24.
//

import Foundation

class User: Codable{
    var password: String
    var email: String
    var name: String
    var lastName: String
    
    init(password: String, email: String, name: String, lastName: String) {
        self.password = password
        self.email = email
        self.name = name
        self.lastName = lastName
    }
}
