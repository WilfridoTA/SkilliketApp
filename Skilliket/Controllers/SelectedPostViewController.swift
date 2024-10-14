//
//  SelectedPostViewController.swift
//  Skilliket
//
//  Created by Will on 29/09/24.
//

import UIKit

class SelectedPostViewController: UIViewController {
    
    @IBOutlet weak var BackgroundView: UIView!
    @IBOutlet weak var ApproveBUtton: UIButton!
    @IBOutlet weak var discardButton: UIButton!
    
    var ourApp:App?
    var actualAdmin:Admin?
    var actualCommunity:Community?
    var actualPost:Any?
    
    @IBOutlet var continueDescriptionLabel: UILabel!
    @IBOutlet var postImage: UIImageView!
    @IBOutlet var publicationDate: UILabel!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var userPhoto: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Personalizamos el fondo
        BackgroundView.layer.cornerRadius = 18
        BackgroundView.layer.shadowColor = UIColor.black.cgColor
        BackgroundView.layer.shadowOpacity = 0.5
        BackgroundView.layer.shadowOffset = CGSize(width: 4, height: 4)
        BackgroundView.layer.shadowRadius = 6
        
        //Personalizamos los botones
        ApproveBUtton.layer.cornerRadius = 18
        discardButton.layer.cornerRadius = 18
        
        setUpAll()
    }
    

    func setUpAll(){
        if let p=actualPost as? Post{
            usernameLabel.text=p.creator
            publicationDate.text="\(p.dateCreated.day)/\(p.dateCreated.month)/\(p.dateCreated.year)"
            descriptionLabel.text=p.text
            if let i=p.image{
                cargarImagenDesdeURL(url: i, imageView: postImage)
            }
            let member=getMember(name: p.creator)
            if let image=member!.profileImage{
                cargarImagenDesdeURL(url: member!.profileImage!, imageView: userPhoto)
            }
        } else if let p=actualPost as? New{
            usernameLabel.text=p.creator
            publicationDate.text="\(p.dateCreated.day)/\(p.dateCreated.month)/\(p.dateCreated.year)"
            descriptionLabel.text="\(p.text) \nLink: \(p.link)"
            let member=getMember(name: p.creator)
            if let image=member!.profileImage{
                cargarImagenDesdeURL(url: member!.profileImage!, imageView: userPhoto)
            }
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func removePostFromWaiting(post:Post){
        if let wp=actualCommunity!.waitingPost{
            for i in 0...wp.count-1{
                if wp[i].text==post.text{
                    actualCommunity!.waitingPost!.remove(at: i)
                }
            }
        }
    }
    
    func removeNewFromWaiting(new:New){
        if let wp=actualCommunity!.waitingNews{
            for i in 0...wp.count-1{
                if wp[i].text==new.text{
                    actualCommunity!.waitingNews!.remove(at: i)
                }
            }
        }
    }
    
    
    @IBAction func acceptPost(_ sender: UIButton) {
        if let p=actualPost as? Post{
            removePostFromWaiting(post: p)
            actualCommunity!.approvedPost!.append(p)
        } else if let n=actualPost as? New{
            removeNewFromWaiting(new: n)
            actualCommunity!.approvedNews!.append(n)
        }
        redefineCommunity(com: actualCommunity!)
        
        performSegue(withIdentifier: "unwindToPostApproveViewController", sender: self)
    }
    
    @IBAction func rejectPost(_ sender: UIButton) {
        if let p=actualPost as? Post{
            removePostFromWaiting(post: p)
            actualCommunity!.unnaprovedPost!.append(p)
        } else if let n=actualPost as? New{
            removeNewFromWaiting(new: n)
            actualCommunity!.unnaprovedNews!.append(n)
        }
        redefineCommunity(com: actualCommunity!)
        
        performSegue(withIdentifier: "unwindToPostApproveViewController", sender: self)
    }
    
    func redefineCommunity(com:Community){
        for i in 0...ourApp!.communities.count-1{
            if ourApp!.communities[i].name==com.name{
                ourApp!.communities.remove(at: i)
                ourApp!.communities.append(com)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextView=segue.destination as? PostApproveViewController{
            nextView.ourApp=ourApp
            nextView.actualCommunity=actualCommunity
        }
    }
}
