//
//  Community.swift
//  Jsons
//
//  Created by Astrea Polaris on 07/10/24.
//

import Foundation

class Community: Codable{
    var name: String
    var country: String
    var device: SkilliketDevice
    var state: String
    var city: String
    var zone: String
    var members: [String]?
    var forums: [Forum]?
    var approvedProjects: [Project]?
    var waitingProjects: [Project]?
    var unnaprovedProjects: [Project]?
    var approvedPost: [Post]?
    var waitingPost: [Post]?
    var unnaprovedPost: [Post]?
    var reports:[Report]?
    var approvedNews:[New]?
    var waitingNews:[New]?
    var unnaprovedNews:[New]?
    var image:URL
    
    init(name: String, country: String, device: SkilliketDevice, state: String, city: String, zone: String, members: [String]? = nil, forums: [Forum]? = nil, approvedProjects: [Project]? = nil, waitingProjects: [Project]? = nil, unnaprovedProjects: [Project]? = nil, approvedPost: [Post]? = nil, waitingPost: [Post]? = nil, unnaprovedPost: [Post]? = nil, reports: [Report]? = nil, approvedNews: [New]? = nil, waitingNews: [New]? = nil, unnaprovedNews: [New]? = nil, image: URL) {
        self.name = name
        self.country = country
        self.device = device
        self.state = state
        self.city = city
        self.zone = zone
        self.members = members
        self.forums = forums
        self.approvedProjects = approvedProjects
        self.waitingProjects = waitingProjects
        self.unnaprovedProjects = unnaprovedProjects
        self.approvedPost = approvedPost
        self.waitingPost = waitingPost
        self.unnaprovedPost = unnaprovedPost
        self.reports = reports
        self.approvedNews = approvedNews
        self.waitingNews = waitingNews
        self.unnaprovedNews = unnaprovedNews
        self.image = image
    }
}
