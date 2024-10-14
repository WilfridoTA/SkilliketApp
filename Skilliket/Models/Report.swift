//
//  Report.swift
//  Jsons
//
//  Created by Astrea Polaris on 07/10/24.
//

import Foundation

class Report: Content{
    let dateReport: DateComponents
    let timeReport: DateComponents
    let location: String
    let image: URL?
    let video: URL?
    
    init(dateReport: DateComponents, timeReport: DateComponents, location: String, image: URL?, video: URL?, text: String, timeCreated: DateComponents, dateCreated: DateComponents, creator: String, approved: ApprovedState) {
        self.dateReport = dateReport
        self.timeReport = timeReport
        self.location = location
        self.image = image
        self.video = video
            
        super.init(text: text, timeCreated: timeCreated, dateCreated: dateCreated, creator: creator, approved: approved)
    }
        
    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let dateReport = try container.decode(DateComponents.self, forKey: .dateReport)
        let timeReport = try container.decode(DateComponents.self, forKey: .timeReport)
        let location = try container.decode(String.self, forKey: .location)
        let image = try container.decode(URL?.self, forKey: .image)
        let video = try container.decode(URL?.self, forKey: .video)
        let text = try container.decode(String.self, forKey: .text)
        let timeCreated = try container.decode(DateComponents.self, forKey: .timeCreated)
        let dateCreated = try container.decode(DateComponents.self, forKey: .dateCreated)
        let creator = try container.decode(String.self, forKey: .creator)
        let approved = try container.decode(ApprovedState.self, forKey: .approved)
            
        self.init(dateReport: dateReport,timeReport: timeReport,location: location,image: image,video: video,text: text,timeCreated: timeCreated,dateCreated: dateCreated,creator: creator,approved: approved)
        }
    
    enum CodingKeys: String, CodingKey {
            case dateReport
            case timeReport
            case location
            case image
            case video
            case text
            case timeCreated
            case dateCreated
            case creator
            case approved
        }
}
