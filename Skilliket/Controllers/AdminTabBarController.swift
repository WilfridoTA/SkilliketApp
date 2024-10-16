//
//  AdminTabBarController.swift
//  Skilliket
//
//  Created by Astrea Polaris on 13/10/24.
//

import UIKit

class AdminTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let navigationController = self.navigationController {
            navigationController.setNavigationBarHidden(true, animated: false)
        }
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
