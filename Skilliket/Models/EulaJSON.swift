//
//  EulaJSON.swift
//  Eula&Terminos
//
//  Created by Astrea Polaris on 13/10/24.
//

import Foundation

class EulaJSON: Codable{
    var title: String
    var lastUpdated: String
    var content: String
    
    init(title: String, lastUpdated: String, content: String) {
        self.title = title
        self.lastUpdated = lastUpdated
        self.content = content
    }
}


extension EulaJSON{
    static func fetchEula() async throws -> EULA {
            var urlComponents = URLComponents(string: "https://martinmolina.com.mx/martinmolina.com.mx/reto_skiliket/Equipo5/EULA.json")!
            
            let (data, response) = try await URLSession.shared.data(from: urlComponents.url!)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                throw ErrorJSON.errorConnect
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let miEulaJSON = try jsonDecoder.decode(EulaJSON.self, from: data)
                
                let miEula=EULA(title: miEulaJSON.title, lastUpdated: miEulaJSON.lastUpdated, content: miEulaJSON.content)
                
                return miEula
            } catch {
                print(error)
                throw error
            }
        }
}
