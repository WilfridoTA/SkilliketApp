//
//  Data.swift
//  Jsons
//
//  Created by Astrea Polaris on 07/10/24.
//

import Foundation

class Data: Codable {
    let date, time: DateComponents
    
    init(date: DateComponents, time: DateComponents) {
        self.date = date
        self.time = time
    }
}
