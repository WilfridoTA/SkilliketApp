//
//  ProjectAnnouncementViewController.swift
//  Skilliket
//
//  Created by Will on 12/10/24.
//

import UIKit

class ProjectAnnouncementViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var announcementTable: UITableView!
    
    var ourApp:App?
    var actualMember:Member?
    var actualProject:Project?
    var announcmentsArr:[Post]?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //FALTA AGREGAR INFO Y SOBREADO A LA TABLA
        announcementTable.dataSource=self
        announcementTable.delegate=self
        
        announcmentsArr=actualProject!.announcements
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return announcmentsArr!.count
    }
    
    //Cada sección tendra una fila
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = announcementTable.dequeueReusableCell(withIdentifier: "announcementCell", for: indexPath) as! ProjectAnnouncementTableViewCell
        
        let arreglo = announcmentsArr![indexPath.section]
        
        cell.projectAnnouncementDescription.text=arreglo.text
                cell.projectAnnouncementUserName.text=arreglo.creator
                cell.projectAnnouncementDate.text = "\(arreglo.dateCreated.day!)/\(arreglo.dateCreated.month!)/\(arreglo.dateCreated.year!)"
                if let im=getMember(name: arreglo.creator)?.profileImage{
                    cargarImagenDesdeURL(url: im, imageView: cell.projectAnnouncementImage)
                }
        
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
    
    //Mantener constante el tamaño de cada celda
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180 //150 Será el tamaño para todas las tablas
    }

}
