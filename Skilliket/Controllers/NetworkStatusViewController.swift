//
//  NetworkStatusViewController.swift
//  Skilliket
//
//  Created by Will on 29/09/24.
//

import UIKit

class NetworkStatusViewController: UIViewController {
    var ourApp:App?
    var actualAdmin:Admin?
    var networkStatuses:Statuses?

    @IBOutlet var totalPercentage: UILabel!
    @IBOutlet var totalDevices: UILabel!
    @IBOutlet var switchRatio: UILabel!
    @IBOutlet var switchPercentage: UILabel!
    @IBOutlet var routerRatio: UILabel!
    @IBOutlet var routerPercentage: UILabel!
    @IBOutlet var clientsPercentage: UILabel!
    @IBOutlet var clientsTotal: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            do {
                if let token = try await NetworkStatusJSONS.getToken() {
                    let networkStatuses = try await NetworkStatusJSONS.fetchNetworkStatus(token: token)
                    // Aquí puedes manejar `networkStatuses` según lo necesites
                } else {
                    print("Error: No se pudo obtener el token")
                }
            } catch {
                print("Error al obtener el estado de la red: \(error)")
            }
        }

        
    }
    
    func setUp(){
        let actualStatuus=networkStatuses![networkStatuses!.count-1]
        totalPercentage.text=actualStatuus.networkDevices.totalPercentage
        totalDevices.text=actualStatuus.networkDevices.totalDevices
        var Switch:[NetworkDevice?]=[]
        for i in 0...actualStatuus.networkDevices.networkDevices.count-1{
            if actualStatuus.networkDevices.networkDevices[i].deviceType == .switches{
                Switch.append(actualStatuus.networkDevices.networkDevices[i])
            }
        }
        switchRatio.text=Switch[0]!.healthyRatio
        switchPercentage.text=Switch[0]!.healthyPercentage
        
        var router:[NetworkDevice?]=[]
        for i in 0...actualStatuus.networkDevices.networkDevices.count-1{
            if actualStatuus.networkDevices.networkDevices[i].deviceType == .routers{
                router.append(actualStatuus.networkDevices.networkDevices[i])
            }
        }
        
        routerRatio.text=router[0]!.healthyRatio
        routerPercentage.text=router[0]!.healthyPercentage
        
        clientsTotal.text=actualStatuus.clients.totalConnected
        clientsPercentage.text=actualStatuus.clients.totalPercentage
    }
}
