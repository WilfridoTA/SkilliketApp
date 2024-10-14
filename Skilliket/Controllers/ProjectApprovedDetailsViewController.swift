//
//  ProjectApprovedDetailsViewController.swift
//  Skilliket
//
//  Created by Will on 13/10/24.
//

import UIKit

class ProjectApprovedDetailsViewController: UIViewController {
    
    @IBOutlet var ProjectImage: UIImageView!
    @IBOutlet var continueTextLabel: UILabel!
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var publicationDate: UILabel!
    @IBOutlet var username: UILabel!
    @IBOutlet var userImage: UIImageView!
    @IBOutlet weak var projectApprovedBackground: UIView!
    @IBOutlet weak var projectDetailsApproved: UIButton!
    @IBOutlet weak var projectDetailsDiscard: UIButton!
    
    var ourApp:App?
    var actualCommunity:Community?
    var actualProject:Project?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Personalizamos el fondo
        projectApprovedBackground.layer.cornerRadius = 18
        projectApprovedBackground.layer.shadowColor = UIColor.black.cgColor
        projectApprovedBackground.layer.shadowOpacity = 0.5
        projectApprovedBackground.layer.shadowOffset = CGSize(width: 4, height: 4)
        projectApprovedBackground.layer.shadowRadius = 6
        
        //Personalizamos los botones
        projectDetailsApproved.layer.cornerRadius = 18
        projectDetailsDiscard.layer.cornerRadius = 18
    }
    
    func setUpAll(){
        textLabel.text=actualProject!.description
        username.text=actualProject!.creator
        cargarImagenDesdeURL(url: actualProject!.imagen, imageView: ProjectImage)
        var member=getMember(name: actualProject!.creator)
        if let im=member!.profileImage{
            cargarImagenDesdeURL(url: im, imageView: userImage)
        }
    }
    
    func getMember(name:String)->Member?{
        //te da el objeto Member que tiene el nombre ingresado
        var member:Member?=nil
        for i in 0...ourApp!.userMembers.count-1{
            let m=ourApp!.userMembers[i]
            if m.name==name{
                member=m
            }
        }
        return member
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
    
    func removeProjectFromWaiting(project:Project){
        if let wp=actualCommunity!.waitingProjects{
            for i in 0...wp.count-1{
                if wp[i].name==project.name{
                    actualCommunity!.waitingProjects!.remove(at: i)
                }
            }
        }
    }
    
    func redefineCommunity(com:Community){
        for i in 0...ourApp!.communities.count-1{
            if ourApp!.communities[i].name==com.name{
                ourApp!.communities.remove(at: i)
                ourApp!.communities.append(com)
            }
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

    
    @IBAction func acceptProject(_ sender: UIButton) {
        removeProjectFromWaiting(project: actualProject!)
        actualCommunity!.approvedProjects!.append(actualProject!)
        redefineCommunity(com: actualCommunity!)
    }
    
    
    @IBAction func rejectProject(_ sender: UIButton) {
        removeProjectFromWaiting(project: actualProject!)
        actualCommunity!.unnaprovedProjects!.append(actualProject!)
        redefineCommunity(com: actualCommunity!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextView=segue.destination as? ProjectToBeApprovedViewController{
            nextView.ourApp=ourApp
            nextView.actualCommunity=actualCommunity
        }
    }
}
