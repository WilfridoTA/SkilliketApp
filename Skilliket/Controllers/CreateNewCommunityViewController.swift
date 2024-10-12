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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Indicamos a quiend se deben notificar los eventos del teclado
        self.nameTextField.delegate = self
        self.descriptionTextField.delegate = self
        //Mandamos a llamar el pop up button
        setUpCityButton()
        updateAreaButton()
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
        CityPopUp.menu = UIMenu(children: [
            UIAction(title: "Select your city.", state: .on, handler: optionClosure),
            UIAction(title: "Mexico City", handler: optionClosure),
            UIAction(title: "Monterrey City", handler: optionClosure),
            UIAction(title: "Canada", handler: optionClosure)
        ])
    }
    
    func updateAreaButton(){
        //Creamos un arreglo vacio
        var areaMenu:[UIAction] = []
        
        let optionClosure = {(action: UIAction) in
            self.selectedArea = action.title
            //print(action.title)
        } //Guardamos el valor seleccionado de la ciudad
        
        //-------------- AREA --------------------
        switch selectedCity{
        case "Mexico City":
            areaMenu = [
                UIAction(title: "Choose city area.", handler: optionClosure),
                UIAction(title: "Centro", handler: optionClosure),
                UIAction(title: "Norte", handler: optionClosure),
                UIAction(title: "Oriente", handler: optionClosure),
                UIAction(title: "Poniente", handler: optionClosure),
                UIAction(title: "Sur", handler: optionClosure)
            ]
        case "Monterrey City":
            areaMenu = [
                UIAction(title: "MTY1", handler: {action in print(action.title)}),
                UIAction(title: "MTY2", handler: {action in print(action.title)}),
                UIAction(title: "MTY3", handler: {action in print(action.title)}),
                UIAction(title: "MTY4", handler: {action in print(action.title)}),
                UIAction(title: "MTY4", handler: {action in print(action.title)})
            ]
            
        case "Canada":
            areaMenu = [
                UIAction(title: "MOOSE1", handler: {action in print(action.title)}),
                UIAction(title: "MOOSE2", handler: {action in print(action.title)}),
                UIAction(title: "MOOSE3", handler: {action in print(action.title)}),
                UIAction(title: "MOOSE4", handler: {action in print(action.title)}),
                UIAction(title: "MOOSE5", handler: {action in print(action.title)})
            ]
        default:
            areaMenu = [
                UIAction(title: "Choose a city.", handler: {action in print(action.title)})
            ]
        }
        
        areaPopUp.menu = UIMenu(children: areaMenu) //Generamos la lista dependiendo de la ciudad
    }
    
    //MARK: - Button
    @IBAction func CreateCommunityBTN(_ sender: UIButton) {
        if nameTextField.hasText && descriptionTextField.hasText{
            //Guardamos datos
            name = String(nameTextField.text!)
            descrip = String(descriptionTextField.text!)
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
