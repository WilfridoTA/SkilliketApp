//
//  Content.swift
//  Jsons
//
//  Created by Astrea Polaris on 07/10/24.
//

import Foundation

class Content: Codable {
    let text:String
    let timeCreated, dateCreated: DateComponents
    let creator: String
    let approved: ApprovedState

    init(text: String, timeCreated: DateComponents, dateCreated: DateComponents, creator: String, approved: ApprovedState) {
        self.text = text
        self.timeCreated = timeCreated
        self.dateCreated = dateCreated
        self.creator = creator
        self.approved = approved
    }
    

}
