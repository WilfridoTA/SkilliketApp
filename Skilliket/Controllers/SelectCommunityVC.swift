//
//  SelectCommunityVC.swift
//  Skilliket
//
//  Created by Astrea Polaris on 01/10/24.
//

import UIKit

class SelectCommunityVC: UIViewController {

    @IBOutlet var joinButton: UIButton!
    @IBOutlet var communityView: UIView!
    @IBOutlet var popUpButtonZone: UIButton!
    @IBOutlet var popUpButtonCity: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ocultar la barra de navegación
        if let navigationController = self.navigationController {
            navigationController.setNavigationBarHidden(true, animated: false)
        }

        setupPopUpButton(button:popUpButtonCity)
        setupPopUpButton(button: popUpButtonZone)
        
        setUpView()
        
        joinButton.layer.cornerRadius=10

        // Do any additional setup after loading the view.
    }
    

    func setupPopUpButton(button:UIButton) {
        let actionClosure = { (action: UIAction) in
            print(action.title)
        }

        var menuChildren: [UIMenuElement] = [
            UIAction(title: "Opción 1", handler: actionClosure),
            UIAction(title: "Opción 2", handler: actionClosure),
            UIAction(title: "Opción 3", handler: actionClosure)
        ]

        // Configurar el menú
        button.menu = UIMenu(options: .displayInline, children: menuChildren)
        button.showsMenuAsPrimaryAction = true
        button.changesSelectionAsPrimaryAction = true

        // Configurar el icono
        let image = UIImage(systemName: "chevron.down") ?? UIImage()
        button.setImage(image, for: .normal)

        // Ajustar los márgenes del título e imagen
        if let imageView = button.imageView {
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                imageView.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -10),
                imageView.topAnchor.constraint(equalTo: button.topAnchor, constant: 0),
                imageView.widthAnchor.constraint(equalToConstant: 20),
                imageView.heightAnchor.constraint(equalToConstant: 20)
            ])
        }

        if let titleLabel = button.titleLabel {
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                titleLabel.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 10),
                titleLabel.centerYAnchor.constraint(equalTo: button.centerYAnchor)
            ])
        }


        button.layer.cornerRadius = 10

        // Ajustar el tamaño del botón si es necesario
        button.sizeToFit()
    }
    
    func setUpView() {
        
        let backgroundLayer = CALayer()
        backgroundLayer.frame = communityView.bounds
        backgroundLayer.backgroundColor = UIColor.systemCyan.withAlphaComponent(0.25).cgColor
        backgroundLayer.cornerRadius=15
        communityView.layer.addSublayer(backgroundLayer)
        
        // Configurar la orilla cyan
        let borderLayer = CALayer()
        borderLayer.frame = CGRect(x: 0, y: 0, width: communityView.bounds.width, height: communityView.bounds.height)
        borderLayer.borderColor = UIColor.systemCyan.cgColor
        borderLayer.borderWidth = 2
        borderLayer.cornerRadius = 15
        communityView.layer.addSublayer(borderLayer)
        
        communityView.layer.cornerRadius = 15
        
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
