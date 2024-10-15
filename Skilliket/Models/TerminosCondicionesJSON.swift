//
//  TerminosCondicionesJSON.swift
//  Eula&Terminos
//
//  Created by Astrea Polaris on 13/10/24.
//

import Foundation

class TerminosCondicionesJSON: Codable{
    var title: String
    var lastUpdated: String
    var content: String
    
    init(title: String, lastUpdated: String, content: String) {
        self.title = title
        self.lastUpdated = lastUpdated
        self.content = content
    }
}


extension TerminosCondicionesJSON{
    static func fetchTerminos() async throws -> TermsAndConditions {
            var urlComponents = URLComponents(string: "http://martinmolina.com.mx/martinmolina.com.mx/reto_skiliket/Equipo5/Term&Conditions.json")!
            
            let (data, response) = try await URLSession.shared.data(from: urlComponents.url!)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                throw ErrorJSON.errorConnect
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let misTerminosJSON = try jsonDecoder.decode(EulaJSON.self, from: data)
                
                let misTerminos=TermsAndConditions(title: misTerminosJSON.title, lastUpdated: misTerminosJSON.lastUpdated, content: misTerminosJSON.content)
                
                return misTerminos
            } catch {
                print(error)
                throw error
            }
        }
}
