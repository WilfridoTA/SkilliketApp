//
//  CreateAccountVC.swift
//  Skilliket
//
//  Created by Astrea Polaris on 30/09/24.
//

import UIKit

class CreateAccountVC: UIViewController {

    @IBOutlet var eulaButton: UIButton!
    @IBOutlet var agreeTermsButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        addMargin(button: agreeTermsButton)
        addMargin(button: eulaButton)
    }
    
    func addMargin(button:UIButton){
        button.layer.borderWidth=1
        button.layer.borderColor=UIColor.darkGray.cgColor
    }
    
    @IBAction func unwindToCreateAccountVC(_ segue: UIStoryboardSegue) {
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
