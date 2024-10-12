//
//  NewForumsViewController.swift
//  Skilliket
//
//  Created by Will on 11/10/24.
//

import UIKit

class NewForumsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let navigationController = self.navigationController {
            navigationController.setNavigationBarHidden(false, animated: true)
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
