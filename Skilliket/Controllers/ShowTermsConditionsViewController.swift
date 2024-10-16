//
//  ShowTermsConditionsViewController.swift
//  Skilliket
//
//  Created by Astrea Polaris on 15/10/24.
//

import UIKit

class ShowTermsConditionsViewController: UIViewController {

    var terms:TermsAndConditions?
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var miniView: UIView!
    @IBOutlet var scrollView: UIScrollView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        miniView.layer.borderWidth = 1
        miniView.layer.borderColor = UIColor.black.cgColor
        miniView.layer.cornerRadius = 10 // Ajusta según sea necesario
        miniView.clipsToBounds = true

        scrollView.showsVerticalScrollIndicator=true
        
        Task {
            do {
                terms = try await TerminosCondicionesJSON.fetchTerminos()
                textLabel.text="\(terms!.content) \nLast updated: \(terms!.lastUpdated)"
            } catch {
                print("Fetch Terminos failed with error: ")
            }
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
