//
//  SelectCommunityVC.swift
//  Skilliket
//
//  Created by Astrea Polaris on 01/10/24.
//

import UIKit

class SelectCommunityVC: UIViewController {

    @IBOutlet var communityImage: UIImageView!
    @IBOutlet var communityName: UILabel!
    @IBOutlet var communityView: UIView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var joinButton: UIButton!
    @IBOutlet var popUpButtonZone: UIButton!
    @IBOutlet var popUpButtonCity: UIButton!
    var actualMember:Member?
    var ourApp:App?
    var city:String?
    var zone:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ocultar la barra de navegación
        if let navigationController = self.navigationController {
            navigationController.setNavigationBarHidden(true, animated: false)
        }

        communityView.isHidden=true
        setUpCityButton()
        firstSetUpZoneButton()
        
        setUpView()
        
        joinButton.layer.cornerRadius=10

        // Do any additional setup after loading the view.
    }
    
    func updatePopUpButtonTitle(button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
        
        // Actualizar manualmente el título del botón emergente
        if let titleLabel = button.titleLabel {
            titleLabel.text = title
        }
        
        button.layoutIfNeeded()
        button.setNeedsLayout()
    }
    
    func setUpCityButton(){
        var configuration = UIButton.Configuration.plain()
            configuration.title = "Select City"
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16)
        
        let actionClosure = { (action: UIAction) in self.popUpButtonCity
            if action.title != "Select city"{
                self.city = action.title
                self.updateZoneButton()
            }
            self.popUpButtonCity.configuration?.attributedTitle = AttributedString(action.title)
            self.popUpButtonCity.setNeedsLayout()
        }
            
        var menuChildren: [UIMenuElement] = [UIAction(title: "Select city", handler: actionClosure)]
            
        for i in 0...ourApp!.communities.count-1 {
            menuChildren.append(UIAction(title: ourApp!.communities[i].city, handler: actionClosure))
        }
        


        // Configurar el menú
        popUpButtonCity.configuration = configuration
        popUpButtonCity.menu = UIMenu(options: .displayInline, children: menuChildren)
        popUpButtonCity.showsMenuAsPrimaryAction = true
        popUpButtonCity.changesSelectionAsPrimaryAction = true

        popUpButtonCity.layer.cornerRadius = 10

        // Ajustar el tamaño del botón si es necesario
        popUpButtonCity.sizeToFit()
    }

    func firstSetUpZoneButton() {
        var configuration = UIButton.Configuration.plain()
            configuration.title = "Select city first"
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16)
        
        let actionClosure = { (action: UIAction) in self.popUpButtonZone
            self.zone = action.title
            self.popUpButtonZone.configuration?.attributedTitle = AttributedString(action.title)
            self.popUpButtonZone.setNeedsLayout()
        }
            
        var menuChildren: [UIMenuElement] = []
            
        menuChildren.append(UIAction(title: "Select city first", attributes: .disabled, handler: actionClosure))


        // Configurar el menú
        popUpButtonZone.configuration = configuration
        popUpButtonZone.menu = UIMenu(options: .displayInline, children: menuChildren)
        popUpButtonZone.showsMenuAsPrimaryAction = true
        popUpButtonZone.changesSelectionAsPrimaryAction = true

        popUpButtonZone.layer.cornerRadius = 10

        // Ajustar el tamaño del botón si es necesario
        popUpButtonZone.sizeToFit()
    }
    
    func updateZoneButton(){
        let actionClosure = { (action: UIAction) in self.popUpButtonZone
            self.zone = action.title
            self.updatePopUpButtonTitle(button: self.popUpButtonZone, title: action.title)
            self.updateCommunityView()
        }
        
        var menuChildren: [UIMenuElement] = [UIAction(title: "Select zone", handler: actionClosure)]
            
        for i in 0...ourApp!.communities.count-1{
            if ourApp!.communities[i].city==city{
                menuChildren.append(UIAction(title: ourApp!.communities[i].zone, handler: actionClosure))
            }
        }

        // Configurar el menú
        popUpButtonZone.menu = UIMenu(options: .displayInline, children: menuChildren)
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
    
    func updateCommunityView(){
        communityView.isHidden=false
        let community=getCommunity()
        communityName.text=community!.name
        cargarImagenDesdeURL(url: community!.image, imageView: communityImage)
    }
                                     
    func cargarImagenDesdeURL(url: URL, imageView: UIImageView) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard let data = data, error == nil else {
            print("Error al cargar la imagen: \(error?.localizedDescription ?? "Sin descripción de error")")
            return
        }
                                             
        DispatchQueue.main.async {
            if let image = UIImage(data: data) {
                imageView.image = image
            } else {
                print("No se pudo crear la imagen")
            }
        }
        }.resume()
    }

    
    func getCommunity()->Community?{
        var community:Community?
        for i in 0...ourApp!.communities.count-1{
            if ourApp!.communities[i].city==city, ourApp!.communities[i].zone==zone{
                community=ourApp!.communities[i]
            }
        }
        return community
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func joinButton(_ sender: UIButton) {
        if let actualCommunity=getCommunity(){
            actualCommunity.members!.append(actualMember!.username)
            performSegue(withIdentifier: "fromSelectCommunityToUserMain", sender: self)
        } else{
            showAlert(title: "Error", message: "Please select your city and zone")
        }
        
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromSelectCommunityToUserMain" {
            if let destinationVC = segue.destination as? UserTBC {
                sendUserTBC(destinationVC)
            }
        }
    }
    
    func sendUserTBC(_ tabBarVC: UITabBarController) {
        if let viewControllers = tabBarVC.viewControllers {
            for (index, viewController) in viewControllers.enumerated() {
                if let navigationController = viewController as? UINavigationController {
                    switch index {
                    case 0:
                        configureUserPostsViewController(navigationController)
                    case 1:
                        configureYourForumsViewController(navigationController)
                    case 2:
                        configureYourProjectsViewController(navigationController)
                    case 3:
                        configureDataGraphViewController(navigationController)
                    default:
                        break
                    }
                }
            }
        }
    }
    
    func configureUserPostsViewController(_ navigationController: UINavigationController) {
        if let userPostsVC = navigationController.topViewController as? UserPostsViewController {
            userPostsVC.actualMember = actualMember
            userPostsVC.ourApp = ourApp
            userPostsVC.actualCommunity=getCommunity()
        }
    }

    func configureYourForumsViewController(_ navigationController: UINavigationController) {
        if let yourForumsVC = navigationController.topViewController as? YourForumsViewController {
            // Configurar YourForumsViewController
            yourForumsVC.actualMember = actualMember
            yourForumsVC.ourApp = ourApp
            yourForumsVC.actualCommunity=getCommunity()
        }
    }

    func configureYourProjectsViewController(_ navigationController: UINavigationController) {
        if let yourProjectsVC = navigationController.topViewController as? YourProjectsViewController {
            // Configurar YourProjectsViewController
            yourProjectsVC.actualMember = actualMember
            yourProjectsVC.ourApp = ourApp
        }
    }

    func configureDataGraphViewController(_ navigationController: UINavigationController) {
        if let dataGraphsVC = navigationController.topViewController as? DataGraphViewController {
            // Configurar DataGraphsViewController
            dataGraphsVC.actualMember = actualMember
            dataGraphsVC.ourApp = ourApp
        }
    }
}
