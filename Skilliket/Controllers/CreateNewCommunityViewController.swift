//
//  CreateNewCommunityViewController.swift
//  Skilliket
//
//  Created by Will on 27/09/24.
//

import UIKit

class CreateNewCommunityViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var CityPopUp: UIButton!
    @IBOutlet weak var areaPopUp: UIButton!
    
    var name:String?
    var descrip:String?
    var selectedCity:String?
    var selectedArea:String?
    var ourApp:App?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Indicamos a quiend se deben notificar los eventos del teclado
        self.nameTextField.delegate = self
        self.descriptionTextField.delegate = self
        //Mandamos a llamar el pop up button
        setUpCityButton()
        updateAreaButton()
        
        hideKeyboardWhenTappedAround()
    }
    
    //MARK: - Cerrar tecladodo
    //Cerrar el teclado al presionar return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() //Aplicar para todos los TextField
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Al tocar afuera indicamos que terminamos de usar el teclado
        self.view.endEditing(true)
    }
    
    
    //MARK: - Pop Up Buttons
    func setUpCityButton(){
        //------------ CITY -----------------
        let optionClosure = {(action: UIAction) in
            self.selectedCity = action.title
            self.updateAreaButton()//Actualizamos los valores del otro pop up button
        } //Guardamos el valor seleccionado de la ciudad
        
        //Configuramos las opciones de la lista city
        
        var menuChildren: [UIAction] = []
        for i in 0...ourApp!.communities.count-1 {
            menuChildren.append(UIAction(title: ourApp!.communities[i].city, handler: optionClosure))
        }
        
        CityPopUp.menu = UIMenu(children: menuChildren)
    }
    
    func updateAreaButton(){
        //Creamos un arreglo vacio
        var areaMenu:[UIAction] = []
        
        let optionClosure = {(action: UIAction) in
            self.selectedArea = action.title
            //print(action.title)
        } //Guardamos el valor seleccionado de la ciudad
        
        //-------------- AREA --------------------
       
        areaMenu = [
            UIAction(title: "Choose city area.", handler: optionClosure),
            UIAction(title: "Center", handler: optionClosure),
            UIAction(title: "Nort", handler: optionClosure),
            UIAction(title: "West", handler: optionClosure),
            UIAction(title: "East", handler: optionClosure),
            UIAction(title: "South", handler: optionClosure)
        ]
        
        
        areaPopUp.menu = UIMenu(children: areaMenu) //Generamos la lista dependiendo de la ciudad
    }
    
    //MARK: - Button
    @IBAction func CreateCommunityBTN(_ sender: UIButton) {
        if nameTextField.hasText && descriptionTextField.hasText{
            //Guardamos datos
            name = String(nameTextField.text!)
            descrip = String(descriptionTextField.text!)
            var country:String
            if selectedCity=="CDMX" || selectedCity=="Guadalajara" || selectedCity=="Ciudad de Monterrey"{
                country="México"
            } else{
                country="Canadá"
            }
            
            var state:String
            switch selectedCity{
            case "CDMX":
                state="Ciudad de México"
            case "Guadalajara":
                state="Jalisco"
            case "Ciudad de Monterrey":
                state="Nuevo León"
            case "Bonnyville":
                state="Alberta"
            default:
                break
            }

            performSegue(withIdentifier: "unwindCommunities", sender: self)
        }
        
        //Imprimir datos
        print("New community info:")
        print("Name: \(String(describing: name))")
        print("Description: \(String(describing: descrip))")
        print("City: \(String(describing: selectedCity))")
        print("Area: \(String(describing: selectedArea))")
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
