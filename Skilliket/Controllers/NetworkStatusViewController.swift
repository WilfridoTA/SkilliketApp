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

    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            do {
                let networkStatuses = try await NetworkStatusJSONS.fetchNetworkStatus()
            } catch {
            }
        }
        
    }
}
