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

enum DeviceType: String, Codable {
    case routers = "Routers"
    case switches = "Switches"
}

typealias OneStatus=Response
typealias Statuses=[OneStatus]

extension NetworkStatusJSONS{
    static func fetchNetworkStatus() async throws -> Statuses {
        var urlComponents = URLComponents(string: "")!

            let (data, response) = try await URLSession.shared.data(from: urlComponents.url!)

            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                throw ErrorJSON.errorConnect
            }
            
            let jsonDecoder = JSONDecoder()
        let networkDeviceJSON = try jsonDecoder.decode(NetworkStatusJSONS.self, from: data)
        return(networkDeviceJSON.response)
    }
}
