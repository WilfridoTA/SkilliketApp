//
//  UserPostsViewController.swift
//  Skilliket
//
//  Created by Astrea Polaris on 02/10/24.
//

import UIKit

class UserPostsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet var table: UITableView!
    var ourApp:App?
    var actualMember:Member?
    var actualCommunity:Community?
    var postsArr:[Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        if let navigationController = self.navigationController {
//            navigationController.setNavigationBarHidden(true, animated: false)
//        }
        
        table.dataSource=self
        table.delegate=self
        if let member=actualMember{
            actualCommunity=getCommunityOfMember(member: member)
        }
        postsArr=getContentsOfCommunity(community: actualCommunity!)
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
    
    //Unwind a esta pantalla
    @IBAction func unwindToNews(unwindSegue: UIStoryboardSegue){}
    
    //MARK: - Funciones de la tabla
    
    //El tamaño del arreglo nos dira el numero de secciones
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1 //Cantidad de secciones a crear
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsArr!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "userPostsCell", for: indexPath) as! UserPostsTableViewCell
        
        //Obtenemos el tamaño del arreglo de proyectos
        let postArr = postsArr![indexPath.row]
        
        //Contenido de cada celda
        if let p=postArr as? Post{
            cell.nameMember.text=p.creator
            cell.descriptionPost.text = p.text
            if let im=p.image{
                cargarImagenDesdeURL(url: im, imageView: cell.imagePost)
            } else{
                cell.imagePost.image = UIImage(systemName: ".square.and.pencil.circle")
            }
            cell.timeTypeLabel.text="\(p.dateCreated.day)/\(p.dateCreated.month)/\(p.dateCreated.year) - Post"
            if let i=getMember(name: p.creator)!.profileImage{
                cargarImagenDesdeURL(url: i, imageView: cell.userImage)
            }
            cell.link.isHidden=true
            
        } else if let p=postArr as? New{
            cell.nameMember.text=p.creator
            cell.descriptionPost.text = p.text
            cell.imagePost.image = UIImage(systemName: ".newspaper")
            cell.timeTypeLabel.text="\(p.dateCreated.day)/\(p.dateCreated.month)/\(p.dateCreated.year) - New"
            if let i=getMember(name: p.creator)!.profileImage{
                cargarImagenDesdeURL(url: i, imageView: cell.userImage)
            }
            cell.link.text="\(p.link)"
        } else if let p=postArr as? Report{
            cell.nameMember.text=p.creator
            cell.descriptionPost.text = "\(p.text) \nLocation: \(p.location)"
            if let im=p.image{
                cargarImagenDesdeURL(url: im, imageView: cell.imagePost)
            } else{
                cell.imagePost.image = UIImage(systemName: ".document")
            }
            cell.timeTypeLabel.text="\(p.dateCreated.day)/\(p.dateCreated.month)/\(p.dateCreated.year) - Report"
            if let i=getMember(name: p.creator)!.profileImage{
                cargarImagenDesdeURL(url: i, imageView: cell.userImage)
            }
            cell.link.isHidden=true
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
    
    func getContentsOfCommunity(community:Community)->[Any]{
            //te da todos los contenidos (posts, news y reports) de una comunidad
            var contents:[Any]=[]
            for i in 0...community.approvedNews!.count-1{
                contents.append(community.approvedNews![i])
            }
            
            for i in 0...community.approvedPost!.count-1{
                contents.append(community.approvedPost![i])
            }
            
            for i in 0...community.reports!.count-1{
                contents.append(community.approvedProjects![i])
            }
            
            return contents
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinatiomVC=segue.destination as? CreateContentViewController{
            destinatiomVC.ourApp=ourApp
            destinatiomVC.actualCommunity=actualCommunity
            destinatiomVC.actualMember=actualMember
        }
    }
}
