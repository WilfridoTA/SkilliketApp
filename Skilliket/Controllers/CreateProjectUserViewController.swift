//
//  CreateProjectUserViewController.swift
//  Skilliket
//
//  Created by Astrea Polaris on 15/10/24.
//

import UIKit

class CreateProjectUserViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        hideKeyboardWhenTappedAround()
    }
    

    //MARK: - Cerrar tecladodo
    //Cerrar el teclado al presionar return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() //Aplicar para todos los TextField
    }
    
    //si se crea el projecto debe actualizarse en miApp y enviarla en el segue de regreso

}
