//
//  TermsConditionsVC.swift
//  Skilliket
//
//  Created by Astrea Polaris on 01/10/24.
//

import UIKit

class TermsConditionsVC: UIViewController {

    var terms:TermsAndConditions?
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var miniView: UIView!
    @IBOutlet var scrollView: UIScrollView!
    var accepted=false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        miniView.layer.borderWidth = 1
        miniView.layer.borderColor = UIColor.black.cgColor
        miniView.layer.cornerRadius = 10 // Ajusta según sea necesario
        miniView.clipsToBounds = true


        scrollView.showsVerticalScrollIndicator=true
        // Do any additional setup after loading the view.
        
        Task {
            do {
                terms = try await TerminosCondicionesJSON.fetchTerminos()
                textLabel.text="\(terms!.content) \nLast updated: \(terms!.lastUpdated)"
            } catch {
                print("Fetch Terminos failed with error: ")
            }
        }
    }
    

    @IBAction func declineTerms(_ sender: UIButton) {
        accepted=false
        performSegue(withIdentifier: "unwindToCreateAccountVC:", sender: self)
    }
    @IBAction func acceptTerms(_ sender: UIButton) {
        accepted=true
        performSegue(withIdentifier: "unwindToCreateAccountVC:", sender: self)
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinatiomVC=segue.destination as? CreateAccountVC{
            destinatiomVC.agreeTerms=accepted
        }
    }


}
