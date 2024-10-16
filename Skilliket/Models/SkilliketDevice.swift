//
//  SkilliketDevice.swift
//  Jsons
//
//  Created by Astrea Polaris on 07/10/24.
//

import Foundation

class SkilliketDevice: Codable {
    let id: Int
    let name: String
    let location: String
    let status: StatusDevice
    var temperatures: [TemperatureData?]
    var winds:[WindData?]
    var noises:[NoiseData?]
    var water:[WaterData?]

    init(id: Int, name: String, location: String, status: StatusDevice) {
        self.id = id
        self.name = name
        self.location = location
        self.status = status
        self.temperatures=[]
        self.winds=[]
        self.noises=[]
        self.water=[]
    }
}

enum StatusDevice: Codable{
    case up
    case down
}



extension SkilliketDevice{
    
    //MARK: MONTERREY
    func fetchTemperatureMTY() {
        guard let url = URL(string: "http://localhost:8082/temperature/mty") else { return }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil else { return }
            print(response)

            do {
                let decodedData = try JSONDecoder().decode(TemperatureJSON.self, from: data) // Decode the data
                DispatchQueue.main.async {
                    self.temperatures = decodedData.temperatureArray
                }
            } catch {
                print("Error decoding temperature data: \(error)")
            }
        }
        task.resume()
    }


    func fetchWindMTY() {
        guard let url = URL(string: "http://localhost:8082/wind/mty") else { return }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil else { return }

            do {
                let decodedData = try JSONDecoder().decode(WindJSON.self, from: data) // Decode the data
                DispatchQueue.main.async {
                    self.winds = decodedData.windArray
                }
            } catch {
                print("Error decoding wind data: \(error)")
            }
        }
        task.resume()
    }


    func fetchWaterMTY() {
        guard let url = URL(string: "http://localhost:8082/water/mty") else { return }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil else { return }

            do {
                let decodedData = try JSONDecoder().decode(WaterJSON.self, from: data)
                DispatchQueue.main.async {
                    self.water = decodedData.waterArray
                }
            } catch {
                print("Error decoding water data: \(error)")
            }
        }
        task.resume()
    }


    func fetchNoiseMTY() {
        guard let url = URL(string: "http://localhost:8082/noise/mty") else { return }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil else { return }

            do {
                let decodedData = try JSONDecoder().decode(NoiseJSON.self, from: data) // Use NoiseJSON for decoding
                DispatchQueue.main.async {
                    self.noises = decodedData.noiseArray
                }
            } catch {
                print("Error decoding noise data: \(error)")
            }
        }
        task.resume()
    }

    //MARK: GDL
    func fetchTemperatureGDL(){
        guard let url = URL(string: "http://localhost:8080/temperature/gdl") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil else { return }
            
            do {
                let temperatures = try JSONDecoder().decode(TemperatureJSON.self, from: data)
                DispatchQueue.main.async {
                    self.temperatures = temperatures.temperatureArray
                }
            } catch {
                print("Error decoding temperature data: \(error)")
            }
        }
        task.resume()
    }

    func fetchWindGDL(){
        guard let url = URL(string: "http://localhost:8080/wind/gdl") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil else { return }
            
            do {
                let winds = try JSONDecoder().decode(WindJSON.self, from: data)
                DispatchQueue.main.async {
                    self.winds = winds.windArray
                }
            } catch {
                print("Error decoding wind data: \(error)")
            }
        }
        task.resume()
    }

    func fetchWaterGDL(){
        guard let url = URL(string: "http://localhost:8080/water/gdl") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil else { return }
            
            do {
                let waters = try JSONDecoder().decode(WaterJSON.self, from: data)
                DispatchQueue.main.async {
                    self.water = waters.waterArray
                }
            } catch {
                print("Error decoding water data: \(error)")
            }
        }
        task.resume()
    }

    func fetchNoiseGDL(){
        guard let url = URL(string: "http://localhost:8080/noise/gdl") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil else { return }
            
            do {
                let noises = try JSONDecoder().decode(NoiseJSON.self, from: data)
                DispatchQueue.main.async {
                    self.noises = noises.noiseArray
                }
            } catch {
                print("Error decoding noise data: \(error)")
            }
        }
        task.resume()
    }

    //MARK: TORONTO
    func fetchTemperatureTRT(){
        guard let url = URL(string: "http://localhost:8081/temperature/canada") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil else { return }
            
            do {
                let temperatures = try JSONDecoder().decode(TemperatureJSON.self, from: data)
                DispatchQueue.main.async {
                    self.temperatures = temperatures.temperatureArray
                }
            } catch {
                print("Error decoding temperature data: \(error)")
            }
        }
        task.resume()
    }

    func fetchWindTRT(){
        guard let url = URL(string: "http://localhost:8081/wind/canada") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil else { return }
            
            do {
                let winds = try JSONDecoder().decode(WindJSON.self, from: data)
                DispatchQueue.main.async {
                    self.winds = winds.windArray
                }
            } catch {
                print("Error decoding wind data: \(error)")
            }
        }
        task.resume()
    }

    func fetchWaterTRT(){
        guard let url = URL(string: "http://localhost:8081/water/canada") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil else { return }
            
            do {
                let waters = try JSONDecoder().decode(WaterJSON.self, from: data)
                DispatchQueue.main.async {
                    self.water = waters.waterArray
                    print(self.water)
                }
            } catch {
                print("Error decoding water data: \(error)")
            }
        }
        task.resume()
    }

    func fetchNoiseTRT(){
        guard let url = URL(string: "http://localhost:8081/noise/canada") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil else { return }
            
            do {
                let noises = try JSONDecoder().decode(NoiseJSON.self, from: data)
                DispatchQueue.main.async {
                    self.noises = noises.noiseArray
                }
            } catch {
                print("Error decoding noise data: \(error)")
            }
        }
        task.resume()
    }

    //MARK: CDMX
    func fetchTemperatureCDMX(){
        guard let url = URL(string: "http://localhost:8083/temperature/cdmx") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil else { return }
            
            do {
                let temperatures = try JSONDecoder().decode(TemperatureJSON.self, from: data)
                DispatchQueue.main.async {
                    self.temperatures = temperatures.temperatureArray
                }
            } catch {
                print("Error decoding temperature data: \(error)")
            }
        }
        task.resume()
    }

    func fetchWindCDMX(){
        guard let url = URL(string: "http://localhost:8083/wind/cdmx") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil else { return }
            
            do {
                let winds = try JSONDecoder().decode(WindJSON.self, from: data)
                DispatchQueue.main.async {
                    self.winds = winds.windArray
                }
            } catch {
                print("Error decoding wind data: \(error)")
            }
        }
        task.resume()
    }

    func fetchWaterCDMX(){
        guard let url = URL(string: "http://localhost:8083/water/cdmx") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil else { return }
            
            do {
                let waters = try JSONDecoder().decode(WaterJSON.self, from: data)
                DispatchQueue.main.async {
                    self.water = waters.waterArray
                }
            } catch {
                print("Error decoding water data: \(error)")
            }
        }
        task.resume()
    }

    func fetchNoiseCDMX(){
        guard let url = URL(string: "http://localhost:8083/noise/cdmx") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil else { return }
            
            do {
                let noises = try JSONDecoder().decode(NoiseJSON.self, from: data)
                DispatchQueue.main.async {
                    self.noises = noises.noiseArray
                }
            } catch {
                print("Error decoding noise data: \(error)")
            }
        }
        task.resume()
    }
    

    
}
