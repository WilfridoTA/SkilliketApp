// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let networkStatusJSONS = try? JSONDecoder().decode(NetworkStatusJSONS.self, from: jsonData)

import Foundation

// MARK: - NetworkStatusJSONS
class NetworkStatusJSONS: Codable {
    let response: [Response]
    let version: String

    init(response: [Response], version: String) {
        self.response = response
        self.version = version
    }
}

// MARK: - Response
class Response: Codable {
    let clients: Clients
    let networkDevices: NetworkDevices
    let timestamp: String

    init(clients: Clients, networkDevices: NetworkDevices, timestamp: String) {
        self.clients = clients
        self.networkDevices = networkDevices
        self.timestamp = timestamp
    }
}

// MARK: - Clients
class Clients: Codable {
    let totalConnected, totalPercentage: String

    init(totalConnected: String, totalPercentage: String) {
        self.totalConnected = totalConnected
        self.totalPercentage = totalPercentage
    }
}

// MARK: - NetworkDevices
class NetworkDevices: Codable {
    let networkDevices: [NetworkDevice]
    let totalDevices, totalPercentage: String

    init(networkDevices: [NetworkDevice], totalDevices: String, totalPercentage: String) {
        self.networkDevices = networkDevices
        self.totalDevices = totalDevices
        self.totalPercentage = totalPercentage
    }
}

// MARK: - NetworkDevice
class NetworkDevice: Codable {
    let deviceType: DeviceType
    let healthyPercentage: String
    let healthyRatio: String

    init(deviceType: DeviceType, healthyPercentage: String, healthyRatio: String) {
        self.deviceType = deviceType
        self.healthyPercentage = healthyPercentage
        self.healthyRatio = healthyRatio
    }
}

// MARK: - TicketResponse
class TicketResponse: Codable {
    let response: ResponsePTT
    let version: String

    init(response: ResponsePTT, version: String) {
        self.response = response
        self.version = version
    }
}

// MARK: - Response
class ResponsePTT: Codable {
    let idleTimeout: Int
    let serviceTicket: String
    let sessionTimeout: Int

    init(idleTimeout: Int, serviceTicket: String, sessionTimeout: Int) {
        self.idleTimeout = idleTimeout
        self.serviceTicket = serviceTicket
        self.sessionTimeout = sessionTimeout
    }
}

enum DeviceType: String, Codable {
    case routers = "Routers"
    case switches = "Switches"
}

typealias OneStatus=Response
typealias Statuses=[OneStatus]

extension NetworkStatusJSONS{
    
    static func getToken() async throws->String?{
            let url="http://localhost:58000/api/v1/ticket"
            var retorno="TokenError"
            let baseURL = URL(string: url)
            var request = URLRequest(url: baseURL!)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        
            let parametros: [String: String] = [
                "username": "cisco",
                "password": "cisco123!"
            ]

            do {
                let jsonData = try JSONSerialization.data(withJSONObject: parametros, options: [])

                //Configurar el cuerpo del request con el JSON
                request.httpBody = jsonData

                // Hacer la solicitud usando URLSession
                let (data, response) = try await URLSession.shared.data(for: request)
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else {
                    throw ErrorJSON.errorConnect
                }
                let ticketResponse = try? JSONDecoder().decode(TicketResponse.self, from: data)
                retorno = ticketResponse?.response.serviceTicket ?? "TokenError"
                
                return retorno

            } catch {
               print("Error al obtener token: \(error)")
            }
            return retorno
        }


    static func fetchNetworkStatus(token:String) async throws -> Statuses {
        let url="http://localhost:58000/api/v1/assurance/health"
        let baseURL = URL(string: url)
        var request = URLRequest(url: baseURL!)
        //request.httpMethod = "GET"
        request.addValue(token, forHTTPHeaderField: "X-Auth-Token")
        
        let (data, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                throw ErrorJSON.errorConnect
            }
            
            let jsonDecoder = JSONDecoder()
        let networkDeviceJSON = try jsonDecoder.decode(NetworkStatusJSONS.self, from: data)
        return(networkDeviceJSON.response)
    }
}
