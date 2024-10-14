//
//  Admin.swift
//  Jsons
//
//  Created by Astrea Polaris on 07/10/24.
//

import Foundation

class Admin: User{
    let id: Int

    init(email: String, password: String, name: String, lastName: String, id: Int) {
        self.id = id
        super.init(password: password, email: email, name: name, lastName: lastName)
    }
    
    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
            
        let email = try container.decode(String.self, forKey: .email)
        let password = try container.decode(String.self, forKey: .password)
        let name = try container.decode(String.self, forKey: .name)
        let lastName = try container.decode(String.self, forKey: .lastName)
        let id = try container.decode(Int.self, forKey: .id)
            
        self.init(email: email, password: password, name: name, lastName: lastName, id: id)
    }
        
    enum CodingKeys: String, CodingKey {
        case email
        case password
        case name
        case lastName
        case id
    }
    
}
