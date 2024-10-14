//
//  Forum.swift
//  Jsons
//
//  Created by Astrea Polaris on 07/10/24.
//

import Foundation

class Forum: Codable {
    var name: String
    var description: String
    var members: [String]?
    var location:String
    var themes:[Themes]
    var image:URL
    var messages:[Message]?
    var creator:String
    var type:TypeForum
    
    init(name: String, description: String, members: [String]? = nil, location: String, themes: [Themes], image: URL, messages: [Message]?, creator: String, type: TypeForum) {
        self.name = name
        self.description = description
        self.members = members
        self.location = location
        self.themes = themes
        self.image = image
        self.messages = messages
        self.creator = creator
        self.type = type
    }
}

enum Themes: Codable{
    case water
    case recycling
    case shelter
    case trash
    case reuse
    case reduce
    case weather
    case animals
    case plants
    case garden
    case security
    case neighbours
}

enum TypeForum: Codable{
    case pub
    case priv
}
