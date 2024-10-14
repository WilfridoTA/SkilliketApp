//
//  Member.swift
//  Jsons
//
//  Created by Astrea Polaris on 07/10/24.
//

import Foundation

class Member: User {
    let username: String
    let profileImage:URL?

    init(username: String, profileImage: URL?, email: String, password: String, name: String, lastName: String) {
        self.username = username
        self.profileImage = profileImage
        super.init(password: password, email: email, name: name, lastName: lastName)
    }
    
    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
            
        let email = try container.decode(String.self, forKey: .email)
        let password = try container.decode(String.self, forKey: .password)
        let name = try container.decode(String.self, forKey: .name)
        let lastName = try container.decode(String.self, forKey: .lastName)
        let username = try container.decode(String.self, forKey: .username)
        let profileImage = try container.decode(URL?.self, forKey: .profileImage)
        
        
        
        self.init(username: username,profileImage: profileImage,email: email,password: password,name: name,lastName: lastName)
    }
        
    enum CodingKeys: String, CodingKey {
        case email
        case password
        case name
        case lastName
        case username
        case profileImage
    }
}
