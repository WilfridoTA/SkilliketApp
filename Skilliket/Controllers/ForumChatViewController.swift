//
//  ForumChatViewController.swift
//  Skilliket
//
//  Created by Astrea Polaris on 16/10/24.
//

import UIKit

class ForumChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var insertText: UITextField!
    @IBOutlet var table: UITableView!
    var ourApp:App?
    var actualMember:Member?
    var actualCommunity:Community?
    var actualForum:Forum?
    var textsArr:[Message]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        table.dataSource=self
        table.delegate=self
        textsArr=actualForum!.messages
    }
    

    //MARK: - Funciones de la tabla
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return textsArr!.count //Cantidad de secciones a crear
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "forumChatCell", for: indexPath) as! ForumChatTableViewCell
        
        //Obtenemos el tamaño del arreglo de proyectos
        let forArr = textsArr![indexPath.section]
        
        if forArr.sender==actualMember!.name{
            cell.otherImage.isHidden=true
            cell.otherMessage.isHidden=true
            
            cell.userMessage.text=forArr.content
            if let im=actualMember!.profileImage{
                cargarImagenDesdeURL(url: im, imageView: cell.userImage)
            }
        } else{
            cell.userImage.isHidden=true
            cell.userMessage.isHidden=true
            
            cell.otherMessage.text=forArr.content
            if let im=getMember(name: forArr.sender)!.profileImage{
                cargarImagenDesdeURL(url: im, imageView: cell.userImage)
            }
        }
        
        return cell
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
                imageView.layer.cornerRadius=10
            } else {
                print("No se pudo crear la imagen")
            }
        }
        }.resume()
    }

}
