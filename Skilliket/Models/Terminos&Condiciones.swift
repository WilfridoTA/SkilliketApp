//
//  Terminos&Condiciones.swift
//  Eula&Terminos
//
//  Created by Astrea Polaris on 13/10/24.
//

import Foundation

class TermsAndConditions: Codable {
    var title: String
    var lastUpdated: String
    var content: String
    
    init(title: String, lastUpdated: String, content: String) {
        self.title = title
        self.lastUpdated = lastUpdated
        self.content = content
    }
}

