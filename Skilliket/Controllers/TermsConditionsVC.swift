//
//  TermsConditionsVC.swift
//  Skilliket
//
//  Created by Astrea Polaris on 01/10/24.
//

import UIKit

class TermsConditionsVC: UIViewController {

    @IBOutlet var miniView: UIView!
    @IBOutlet var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()

        miniView.layer.borderWidth = 1
        miniView.layer.borderColor = UIColor.black.cgColor
        miniView.layer.cornerRadius = 10 // Ajusta según sea necesario
        miniView.clipsToBounds = true


        scrollView.showsVerticalScrollIndicator=true
        // Do any additional setup after loading the view.
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
