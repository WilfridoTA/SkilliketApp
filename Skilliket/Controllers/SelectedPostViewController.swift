//
//  SelectedPostViewController.swift
//  Skilliket
//
//  Created by Will on 29/09/24.
//

import UIKit

class SelectedPostViewController: UIViewController {
    
    @IBOutlet weak var BackgroundView: UIView!
    @IBOutlet weak var ApproveBUtton: UIButton!
    @IBOutlet weak var discardButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Personalizamos el fondo
        BackgroundView.layer.cornerRadius = 18
        BackgroundView.layer.shadowColor = UIColor.black.cgColor
        BackgroundView.layer.shadowOpacity = 0.5
        BackgroundView.layer.shadowOffset = CGSize(width: 4, height: 4)
        BackgroundView.layer.shadowRadius = 6
        
        //Personalizamos los botones
        ApproveBUtton.layer.cornerRadius = 18
        discardButton.layer.cornerRadius = 18
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
