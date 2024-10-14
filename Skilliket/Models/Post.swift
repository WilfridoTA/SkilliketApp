//
//  Post.swift
//  Jsons
//
//  Created by Astrea Polaris on 07/10/24.
//

import Foundation

class Post: Content {
    let image, video, link: URL?
    
    init(image: URL?, video: URL?, link: URL?, text: String, timeCreated: DateComponents, dateCreated: DateComponents, creator: String, approved: ApprovedState) {
        self.image = image
        self.video = video
        self.link = link
        
        super.init(text: text, timeCreated: timeCreated, dateCreated: dateCreated, creator: creator, approved: approved)
    }
    
    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let image = try container.decode(URL?.self, forKey: .image)
        let video = try container.decode(URL?.self, forKey: .video)
        let link = try container.decode(URL?.self, forKey: .link)
        let text = try container.decode(String.self, forKey: .text)
        let timeCreated = try container.decode(DateComponents.self, forKey: .timeCreated)
        let dateCreated = try container.decode(DateComponents.self, forKey: .dateCreated)
        let creator = try container.decode(String.self, forKey: .creator)
        let approved = try container.decode(ApprovedState.self, forKey: .approved)
        
        self.init(
            image: image,
            video: video,
            link: link,
            text: text,
            timeCreated: timeCreated,
            dateCreated: dateCreated,
            creator: creator,
            approved: approved
        )
    }
    
    enum CodingKeys: String, CodingKey {
        case image
        case video
        case link
        case text
        case timeCreated
        case dateCreated
        case creator
        case approved
    }}
