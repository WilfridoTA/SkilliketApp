//
//  EulaViewController.swift
//  Skilliket
//
//  Created by Astrea Polaris on 13/10/24.
//

import UIKit

class EulaViewController: UIViewController {
    
    var eula:EULA?
    var accepted=false
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var miniView: UIView!
    
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
                eula = try await EulaJSON.fetchEula()
                textLabel.text="\(eula!.content) \nLast updated: \(eula!.lastUpdated)"
            } catch {
                print("Fetch Eula failed with error: ")
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

    @IBAction func acceptEula(_ sender: UIButton) {
        accepted=true
        performSegue(withIdentifier: "unwindToCreateAccountFromEula", sender: self)
        //por alguna fucking razón no está reconociendo el segue, checar luego con Martin
    }
    
    @IBAction func declineEula(_ sender: UIButton) {
        accepted=false
        performSegue(withIdentifier: "unwindToCreateAccountFromEula", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindToCreateAccountFromEula" {
            if let destinationVC = segue.destination as? CreateAccountVC {
                
                destinationVC.eula = accepted
            }
        }
    }
}
