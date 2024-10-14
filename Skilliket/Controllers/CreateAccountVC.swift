//
//  CreateAccountVC.swift
//  Skilliket
//
//  Created by Astrea Polaris on 30/09/24.
//

import UIKit

class CreateAccountVC: UIViewController {

    var password:String?
    var ourApp:App?
    var name:String?
    var lastName:String?
    var email:String?
    var username:String?
    var eula:Bool=false
    var agreeTerms=false
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var eulaButton: UIButton!
    @IBOutlet var agreeTermsButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        addMargin(button: agreeTermsButton)
        addMargin(button: eulaButton)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateEula()
        updateTerms()
    }
    
    @IBAction func createAccount(_ sender: UIButton) {
        if verifyAll(){
            ourApp!.userMembers.append(Member(username: username!, profileImage: nil, email: email!, password: password!, name: name!, lastName: lastName!))
            showSuccessAlertAndUnwind()

        }
    }
    
    private func showSuccessAlertAndUnwind() {
        let successMessage = "Su cuenta ha sido creada exitosamente"
        let alert = UIAlertController(title: "Éxito", message: successMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continuar", style: .default) { _ in
            self.performSegue(withIdentifier: "unwindToLoginVC", sender: self)
        })
        present(alert, animated: true)
    }
    
    func addMargin(button:UIButton){
        button.layer.borderWidth=1
        button.layer.borderColor=UIColor.darkGray.cgColor
    }
    
    @IBAction func unwindToCreateAccountVC(_ segue: UIStoryboardSegue) {
        }
    
    
    @IBAction func unwindToCreateAccountFromEula(_ segue: UIStoryboardSegue) {
    }

    func updateTerms(){
        if agreeTerms==true{
            agreeTermsButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
            agreeTermsButton.tintColor = .systemBlue
        } else{
            agreeTermsButton.tintColor = .clear
        }
    }
    
    func updateEula(){
        if eula==true{
            eulaButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
            eulaButton.tintColor = .systemBlue
        } else{
            eulaButton.tintColor = .clear
        }
    }
    
    @IBAction func agreeEula(_ sender: UIButton) {
        eula.toggle()
        updateEula()
    }
    
    
    @IBAction func agreeTermsConditions(_ sender: UIButton) {
        agreeTerms.toggle()
        updateTerms()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func verifyFieldsNotEmpty()->Bool{
        if let name=nameTextField.text, let username=usernameTextField.text, let password=passwordTextField.text, let lastName=lastNameTextField.text, let email=emailTextField.text{
            if name != "",username != "",password != "",lastName != "",email != ""{
                return true
            }
        }
        return false
    }
    
    func verifyEmail()->Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailTextField.text!)
    }
    
    func verifyUsername()->Bool{
        var isNew=true
        let users=ourApp!.userMembers
        for i in 0...users.count-1{
            if users[i].username != usernameTextField.text{
                isNew=isNew && true
            } else{
                isNew=isNew && false
            }
        }
        return isNew
    }
    
    func verifyPassword()->Bool{
        let password=passwordTextField.text!
        let passwordRegex = "^(?=.*[a-zA-Z])(?=.*\\d)(?=.*[!@#$%^&*()\\-_=+{}|?>.<,:;~`']).{8,}$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
        return predicate.evaluate(with: password)
    }
    
    func verifyAll()->Bool{
        if verifyFieldsNotEmpty()==false{
            showAlert(title: "Missing information", message: "Empty field(s), please introduce all of the required data")
            return false
        }
        if verifyUsername()==false{
            showAlert(title: "Invalid username", message: "Username already in use, please select another")
            return false
        }
        if verifyEmail()==false{
            showAlert(title: "Invalid email", message: "Please insert a valid email")
            return false
        }
        if verifyPassword()==false{
            showAlert(title: "Invalid password", message: "Your password must be at least 8 characters long, include at least one number and one special character")
            return false
        }
        if eula==false{
            showAlert(title: "Alert", message: "You must agree to the EULA to continue")
            return false
        }
        if agreeTerms==false{
            showAlert(title: "Alert", message: "You must agree to the terms and conditions to continue")
            return false
        }
        
        name=nameTextField.text
        lastName=lastNameTextField.text
        username=usernameTextField.text
        email=emailTextField.text
        password=passwordTextField.text
        return true
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinatiomVC=segue.destination as? LoginVC{
            destinatiomVC.ourApp=ourApp
        }
    }

}
