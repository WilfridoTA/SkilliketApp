//
//  Message.swift
//  Jsons
//
//  Created by Astrea Polaris on 07/10/24.
//

import Foundation

class Message: Codable {
    var content: String
    let date, time: DateComponents
    let sender: String
    var seenBy:[String]
    
    init(content: String, date: DateComponents, time: DateComponents, sender: String, seenBy: [String]) {
        self.content = content
        self.date = date
        self.time = time
        self.sender = sender
        self.seenBy = seenBy
    }
}
