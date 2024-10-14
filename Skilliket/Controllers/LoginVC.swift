//
//  LoginVC.swift
//  Skilliket
//
//  Created by Astrea Polaris on 30/09/24.
//

import UIKit

class LoginVC: UIViewController {

    var ourApp:App?
    @IBOutlet var eulaButton: UIButton!
    @IBOutlet var privacyNoticeButton: UIButton!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var registerButton: UIButton!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var usernameTextField: UITextField!
    var firstLoad=true
    var actualMember:Member?
    var actualAdmin:Admin?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.addLeftImage(image: UIImage(systemName: "lock"))
        usernameTextField.addLeftImage(image: UIImage(systemName: "person.crop.circle"))
        
        setupButton(button: registerButton, radius: 0)
        setupButton(button: privacyNoticeButton, radius: 10)
        setupButton(button: eulaButton, radius: 10)

        
        // Do any additional setup after loading the view.
        
        if firstLoad{
            firstLoad=false
            Task {
                do {
                    ourApp = try await JSONApp.fetchApp()
                    
                } catch {
                    print("Fetch PhotoInfo failed with error: ")
                }
            }
        }
    }
    
    
    func setupButton(button:UIButton,radius:CGFloat){
        button.layer.cornerRadius=radius
        button.layer.borderWidth=1
        button.layer.borderColor=UIColor.darkGray.cgColor
    }
    
    @IBAction func unwindToLoginVC(_ segue: UIStoryboardSegue) {
        }
    
    
    @IBAction func loginB(_ sender: UIButton) {
        login()
    }
    
    func login(){
        if let username=usernameTextField.text, let password=passwordTextField.text{
            if let member=getMember(name: username){
                if member.password==password{
                    actualMember=member
                    if let community=getCommunityOfMember(member: member){
                        performSegue(withIdentifier: "userLogin", sender: self)
                    } else{
                        performSegue(withIdentifier: "firstLoginSegue", sender: self)
                    }
                } else{
                    showAlert(title: "Error", message: "Incorrect credentials")
                }
            } else if let admin=getAdmin(name: username){
                if admin.password==password{
                    actualAdmin=admin
                    performSegue(withIdentifier: "adminLogin", sender: self)
                } else{
                    showAlert(title: "Error", message: "Incorrect credentials")
                }
                
            } else{
                showAlert(title: "Error", message: "User not found")
            }
        } else{
            showAlert(title: "Error", message: "Introduce login credentials")
        }
    }
    
    func getAdmin(name:String)->Admin?{
        var admin:Admin?=nil
        for i in 0...ourApp!.admins.count-1{
            let a=ourApp!.admins[i]
            if a.name==name{
                admin=a
            }
        }
        return admin
    }
    
    
    func getCommunityOfMember(member:Member)->Community?
    {
        //da la comunidad a la que pertenece un miembro
        var memberCommunity:Community?=nil
        for i in 0...(ourApp!.communities.count-1){
            let community=ourApp!.communities[i]
            if community.members!.contains(member.name){
                memberCommunity=community
            }
        }
        return memberCommunity
    }
    
    func getMember(name:String)->Member?{
        //te da el objeto Member que tiene el nombre ingresado
        var member:Member?=nil
        for i in 0...ourApp!.userMembers.count-1{
            let m=ourApp!.userMembers[i]
            if m.username==name{
                member=m
            }
        }
        return member
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if let identifier=segue.identifier{
            switch identifier{
            case "firstLoginSegue":
                if let destinatiomVC=segue.destination as? SelectCommunityVC{
                    destinatiomVC.actualMember=actualMember
                    destinatiomVC.ourApp=ourApp
                }
            case "userLogin":
                if let destinationVC=segue.destination as? UserTBC{
                    sendUserTBC(destinationVC)
                }
            case "adminLogin":
                if let destinatiomVC=segue.destination as? AdminTabBarController{
                    sendAdminTBC(destinatiomVC)
                }
            case "createAccount":
                if let destinatiomVC=segue.destination as? CreateAccountVC{
                    destinatiomVC.ourApp=ourApp
                }
            default:
                break
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
        }
    }

    func configureYourForumsViewController(_ navigationController: UINavigationController) {
        if let yourForumsVC = navigationController.topViewController as? YourForumsViewController {
            // Configurar YourForumsViewController
            yourForumsVC.actualMember = actualMember
            yourForumsVC.ourApp = ourApp
        }
    }

    func configureYourProjectsViewController(_ navigationController: UINavigationController) {
        if let yourProjectsVC = navigationController.topViewController as? YourProjectsViewController {
            // Configurar YourProjectsViewController
            yourProjectsVC.actualMember = actualMember
            yourProjectsVC.ourApp = ourApp        }
    }

    func configureDataGraphViewController(_ navigationController: UINavigationController) {
        if let dataGraphsVC = navigationController.topViewController as? DataGraphViewController {
            // Configurar DataGraphsViewController
            dataGraphsVC.actualMember = actualMember
            dataGraphsVC.ourApp = ourApp
        }
    }


    func sendAdminTBC(_ tabBarVC: UITabBarController) {
        if let viewControllers = tabBarVC.viewControllers {
            for (index, viewController) in viewControllers.enumerated() {
                if let navigationController = viewController as? UINavigationController {
                    switch index {
                    case 0:
                        configureNetworkStatusViewController(navigationController)
                    case 1:
                        configureCommunitiesViewController(navigationController)
                    case 2:
                        configurePostsCommunitiesViewController(navigationController)
                    case 3:
                        configureProjectCommunitiesViewController(navigationController)
                    default:
                        break
                    }
                }
            }
        }
    }
    
    func configureNetworkStatusViewController(_ navigationController: UINavigationController) {
        if let networkStatusVC = navigationController.topViewController as? NetworkStatusViewController {
            networkStatusVC.actualAdmin=actualAdmin
            networkStatusVC.ourApp = ourApp
        }
    }

    func configureCommunitiesViewController(_ navigationController: UINavigationController) {
        if let communitiesVC = navigationController.topViewController as? CommunitiesViewController {
            communitiesVC.actualAdmin=actualAdmin
            communitiesVC.ourApp = ourApp
        }
    }

    func configurePostsCommunitiesViewController(_ navigationController: UINavigationController) {
        if let postsCommunitiesVC = navigationController.topViewController as? PostsCommunitiesViewController {
            postsCommunitiesVC.actualAdmin=actualAdmin
            postsCommunitiesVC.ourApp = ourApp
        }
    }

    func configureProjectCommunitiesViewController(_ navigationController: UINavigationController) {
        if let projectCommunitiesVC = navigationController.topViewController as? ProjectCommunitiesViewController {
            projectCommunitiesVC.actualAdmin=actualAdmin
            projectCommunitiesVC.ourApp = ourApp
        }
    }


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
