//
//  Project.swift
//  Jsons
//
//  Created by Astrea Polaris on 07/10/24.
//

import Foundation

class Project: Codable{
    var name:String
    var description:String
    let creator:String
    var news:[New]?
    var chat:[Message]?
    var announcements:[Content]?
    var members:[String]?
    var category:[Categories]
    var imagen: URL
    var approved:ApprovedState
    
    init(name: String, description: String, creator: String, news: [New]?, chat: [Message]?, announcements: [Content]?, members: [String]?, category: [Categories], imagen: URL, approved: ApprovedState) {
        self.name = name
        self.description = description
        self.creator = creator
        self.news = news
        self.chat = chat
        self.announcements = announcements
        self.members = members
        self.category = category
        self.imagen = imagen
        self.approved = approved
    }
}

enum Categories: Codable{
    case environment
    case social
    case weather
    case water
    case electricity
    case trash
    case waste
    case RRR
    case temperature
    case transport
    case animals
    case plants
    //agregar más
}

enum ApprovedState: Codable{
    case approved
    case waiting
    case denied
}
