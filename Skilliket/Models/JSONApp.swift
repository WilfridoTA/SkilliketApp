//
//  JSONApp.swift
//  Jsons
//
//  Created by Astrea Polaris on 09/10/24.
//

import Foundation

class JSONApp:Codable{
    var skilliketDevices: [SkilliketDevice]
    var communities: [Community]
    var admins: [Admin]
    var userMembers: [Member]

    init(skilliketDevices: [SkilliketDevice], communities: [Community], userMembers: [Member], admins: [Admin]) {
        self.skilliketDevices = skilliketDevices
        self.communities = communities
        self.userMembers = userMembers
        self.admins = admins
    }
}

enum ErrorJSON: Error, LocalizedError{
    case errorConnect
}

extension JSONApp{
    static func fetchApp() async throws -> App {
            var urlComponents = URLComponents(string: "https://martinmolina.com.mx/martinmolina.com.mx/reto_skiliket/Equipo5/Appjson.json")!
            
            let (data, response) = try await URLSession.shared.data(from: urlComponents.url!)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                throw ErrorJSON.errorConnect
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let miAppJSON = try jsonDecoder.decode(JSONApp.self, from: data)
                
                let miApp = App(userMembers: miAppJSON.userMembers, communities: miAppJSON.communities, skilliketDevices: miAppJSON.skilliketDevices, admins: miAppJSON.admins)
                
                return miApp
            } catch {
                print(error)
                throw error
            }
        }
}
