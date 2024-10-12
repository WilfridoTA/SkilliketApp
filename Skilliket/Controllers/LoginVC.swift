//
//  LoginVC.swift
//  Skilliket
//
//  Created by Astrea Polaris on 30/09/24.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet var eulaButton: UIButton!
    @IBOutlet var privacyNoticeButton: UIButton!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var registerButton: UIButton!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var usernameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.addLeftImage(image: UIImage(systemName: "lock"))
        usernameTextField.addLeftImage(image: UIImage(systemName: "person.crop.circle"))
        
        setupButton(button: registerButton, radius: 0)
        setupButton(button: privacyNoticeButton, radius: 10)
        setupButton(button: eulaButton, radius: 10)

        
        // Do any additional setup after loading the view.
    }
    
    func setupButton(button:UIButton,radius:CGFloat){
        button.layer.cornerRadius=radius
        button.layer.borderWidth=1
        button.layer.borderColor=UIColor.darkGray.cgColor
    }
    
    @IBAction func unwindToLoginVC(_ segue: UIStoryboardSegue) {
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

//para agregar icono al text field
extension UITextField {
    func addLeftImage(image: UIImage?) {
        guard let image = image else { return }

        let imageView = UIImageView(frame: CGRect(x: 5, y: 5, width: 30, height: 30))
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        view.addSubview(imageView)
        
        leftViewMode = .always
        leftView = view
        self.tintColor = .lightGray
    }
}
