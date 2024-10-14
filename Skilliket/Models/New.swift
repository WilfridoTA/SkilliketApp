//
//  New.swift
//  Jsons
//
//  Created by Astrea Polaris on 07/10/24.
//

import Foundation

class New: Content{
    var link: URL
    var category: [NewsCategories]
    
    init(link: URL, category: [NewsCategories], text: String, timeCreated: DateComponents, dateCreated: DateComponents, creator: String, approved: ApprovedState) {
        self.link = link
        self.category = category
        super.init(text: text, timeCreated: timeCreated, dateCreated: dateCreated, creator: creator, approved: approved)
    }
    
    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let link = try container.decode(URL.self, forKey: .link)
        let category = try container.decode([NewsCategories].self, forKey: .category)
        let text = try container.decode(String.self, forKey: .text)
        let timeCreated = try container.decode(DateComponents.self, forKey: .timeCreated)
        let dateCreated = try container.decode(DateComponents.self, forKey: .dateCreated)
        let creator = try container.decode(String.self, forKey: .creator)
        let approved = try container.decode(ApprovedState.self, forKey: .approved)

        self.init(link: link,category: category,text: text,timeCreated: timeCreated,dateCreated: dateCreated,creator: creator,approved: approved)
        }
    
    enum CodingKeys: CodingKey {
        case link
        case category
        case text
        case timeCreated
        case dateCreated
        case creator
        case approved
    }
}

enum NewsCategories:Codable{
    case national
    case international
    case politics
    case environment
    case conflict
    case globalWarming
    case weather
    case social
}
