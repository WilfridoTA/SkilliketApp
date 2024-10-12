//
//  UserTBC.swift
//  Skilliket
//
//  Created by Astrea Polaris on 01/10/24.
//

import UIKit

class UserTBC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

//        if let navigationController = self.navigationController {
//            navigationController.setNavigationBarHidden(true, animated: false)
//        }
        
        //setupMiddleButton()
        // Do any additional setup after loading the view.
    }
    
    func setupMiddleButton() {
            let middleButton = UIButton(frame: CGRect(x: 0, y: 0, width: 64, height: 64))
            middleButton.backgroundColor = UIColor.systemBlue
            middleButton.layer.cornerRadius = middleButton.bounds.height / 2
        middleButton.setImage(UIImage(systemName: "plus"), for: .normal)
        middleButton.tintColor=UIColor.white
            middleButton.addTarget(self, action: #selector(middleButtonAction), for: .touchUpInside)
            
            view.addSubview(middleButton)
            
            middleButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                middleButton.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor),
                middleButton.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -32),
                middleButton.widthAnchor.constraint(equalToConstant: 64),
                middleButton.heightAnchor.constraint(equalToConstant: 64)
            ])
        }
        
        @objc func middleButtonAction() {
            // Aquí puedes manejar la acción del botón dependiendo de la vista actual
            let currentIndex = selectedIndex
            switch currentIndex {
            case 0:
                performSegue(withIdentifier: "createContent", sender: self)
                performSegue(withIdentifier: "createContent", sender: show)
            case 1:
                // Acción para la segunda vista
                print("Acción en la segunda vista")
            case 2:
                // Acción para la tercera vista
                performSegue(withIdentifier: "newForums", sender: self)
            case 3:
                // Acción para la cuarta vista
                print("Acción en la cuarta vista")
            default:
                break
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

}
