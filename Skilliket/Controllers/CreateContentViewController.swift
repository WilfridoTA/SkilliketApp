//
//  CreateContentViewController.swift
//  Skilliket
//
//  Created by Astrea Polaris on 01/10/24.
//

import UIKit

class CreateContentViewController: UIViewController {

    @IBOutlet var postButton: UIButton!
    @IBOutlet var reportButton: UIButton!
    @IBOutlet var newsButton: UIButton!
    @IBOutlet var createView: UIView!
    var ourApp:App?
    var actualMember:Member?
    var actualCommunity:Community?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let navigationController = self.navigationController {
            navigationController.setNavigationBarHidden(false, animated: true)
        }

        // Do any additional setup after loading the view.
        createView.layer.cornerRadius=15
        
        setUpButton(button: postButton,title: "Post",icon: "square.and.pencil.circle.fill")
        setUpButton(button: reportButton,title:"Report",icon: "exclamationmark.bubble.fill")
        setUpButton(button: newsButton,title: "New",icon: "newspaper.circle.fill")
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        if let navigationController = self.navigationController {
            navigationController.setNavigationBarHidden(false, animated: true)
        }
    }
    
    func setUpButton(button:UIButton,title:String,icon:String){
        var configuration = UIButton.Configuration.plain()
        configuration.imagePlacement = .top
        configuration.titleAlignment = .center
        configuration.imagePadding = 8 // Espacio entre el icono y el texto
        
        button.setTitle(title, for: .normal)
        button.setImage(UIImage(systemName: icon)?.withRenderingMode(.alwaysTemplate), for: .normal)
        
        // Establece el color del texto y la imagen
        button.setTitleColor(.systemCyan, for: .normal)
        button.tintColor = .systemCyan
        
        button.backgroundColor = UIColor.white
        
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 55)
            button.setPreferredSymbolConfiguration(symbolConfig, forImageIn: .normal)
        
        button.layer.cornerRadius=15
        button.configuration=configuration
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinatiomVC=segue.destination as? CreateNewsViewController{
            destinatiomVC.ourApp=ourApp
            destinatiomVC.actualCommunity=actualCommunity
            destinatiomVC.actualMember=actualMember
        } else if let destinatiomVC=segue.destination as? CreateReportViewController{
            destinatiomVC.ourApp=ourApp
            destinatiomVC.actualCommunity=actualCommunity
            destinatiomVC.actualMember=actualMember
        } else if let destinatiomVC=segue.destination as? CreatePostViewController{
            destinatiomVC.ourApp=ourApp
            destinatiomVC.actualCommunity=actualCommunity
            destinatiomVC.actualMember=actualMember
        }
    }

}
