//
//  JoinProjectViewController.swift
//  Skilliket
//
//  Created by Will on 14/10/24.
//

import UIKit

class JoinProjectViewController: UIViewController {
    
    @IBOutlet weak var joinProjectTable: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        /*
         adaptar cuando se tenga la lista
         if forumsArr!.count==0{
            showAlert(title: "Hey!", message: "Seems like you have joined to all the available forums of your community")
        }
         */
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    //si se une al projecto debe actualizarse en miApp y enviarla en el segue de regreso
}
