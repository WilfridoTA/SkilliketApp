//
//  YourForumsViewController.swift
//  Skilliket
//
//  Created by Will on 12/10/24.
//

import UIKit

class YourForumsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var ourApp:App?
    var actualMember:Member?
    var actualCommunity:Community?
    var forumsArr:[Forum]?
    
    @IBOutlet weak var yourForumsTable: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        yourForumsTable.dataSource=self
        yourForumsTable.delegate=self
        
        //Personalizamos las celdas
        yourForumsTable.layer.shadowColor = UIColor.black.cgColor
        yourForumsTable.layer.shadowOpacity = 0.5
        yourForumsTable.layer.shadowOffset = CGSize(width: 4, height: 4)
        yourForumsTable.layer.shadowRadius = 6
        
        if let member=actualMember{
            actualCommunity=getCommunityOfMember(member: member)
        }
        forumsArr=getForumsOfMember(member: actualMember!)
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
    
    func getForumsOfMember(member:Member)->[Forum]{
        //da los foros en los que esta inscrito un miembro (como creador o solo como participante)
        var forumOfMember:[Forum]=[]
        for i in 0...(actualCommunity!.forums!.count-1){
            let forum=actualCommunity!.forums![i]
            if forum.members!.contains(member.name){
                forumOfMember.append(forum)
            }
        }
        return forumOfMember
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    //MARK: - Funciones de la tabla
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return forumsArr!.count //Cantidad de secciones a crear
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = yourForumsTable.dequeueReusableCell(withIdentifier: "yourForumsCell", for: indexPath) as! YourForumsTableViewCell
        
        //Obtenemos el tamaño del arreglo de proyectos
        let forArr = forumsArr![indexPath.section]
        
        cell.yourForumsDescription.text=forArr.description
        cell.yourForumsLocation.text=forArr.location
        cell.yourForumsName.text=forArr.name
        cell.yourForumsNumMembers.text="\(forumsArr!.count)"
        cargarImagenDesdeURL(url: forArr.image, imageView: cell.yourForumsImage)
        
        return cell
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
    
    //Mantener constante el tamaño de cada celda
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200 //150 Será el tamaño para todas las tablas
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinatiomVC=segue.destination as? NewForumsViewController{
            destinatiomVC.ourApp=ourApp
            destinatiomVC.actualCommunity=actualCommunity
            destinatiomVC.actualMember=actualMember
        }
    }
}
