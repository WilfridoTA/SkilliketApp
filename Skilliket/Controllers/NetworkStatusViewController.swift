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
    
    @IBOutlet weak var networkBackground: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        networkBackground.layer.cornerRadius = 18
        networkBackground.layer.shadowColor = UIColor.darkGray.cgColor
        networkBackground.layer.shadowOpacity = 1
        networkBackground.layer.shadowOffset = CGSize(width: 0, height: 0)
        networkBackground.layer.shadowRadius = 10
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
