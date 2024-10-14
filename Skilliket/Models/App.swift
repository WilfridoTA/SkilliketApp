//
//  App.swift
//  Jsons
//
//  Created by Astrea Polaris on 07/10/24.
//

import Foundation

class App: Codable{
    var userMembers:[Member]
    var communities:[Community]
    var skilliketDevices:[SkilliketDevice]
    var admins:[Admin]
    
    init(userMembers: [Member], communities: [Community], skilliketDevices: [SkilliketDevice], admins: [Admin]) {
        self.userMembers = userMembers
        self.communities = communities
        self.skilliketDevices = skilliketDevices
        self.admins = admins
    }
    
}
