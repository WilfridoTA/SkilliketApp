//
//  JoinProjectViewController.swift
//  Skilliket
//
//  Created by Will on 14/10/24.
//

import UIKit

class JoinProjectViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var joinProjectTable: UITableView!
    
    
    var ourApp:App?
    var actualMember:Member?
    var joinProjectsArr:[Project]?

    override func viewDidLoad() {
        super.viewDidLoad()


        // Do any additional setup after loading the view.
        
        /*
         adaptar cuando se tenga la lista
         if forumsArr!.count==0{
            showAlert(title: "Hey!", message: "Seems like you have joined to all the available forums of your community")
        }
         */

        joinProjectTable.dataSource = self
        joinProjectTable.delegate = self
        
        joinProjectTable.layer.shadowColor = UIColor.black.cgColor
        joinProjectTable.layer.shadowOpacity = 0.5
        joinProjectTable.layer.shadowOffset = CGSize(width: 4, height: 4)
        joinProjectTable.layer.shadowRadius = 6
        
        //Llenamos el arreglo
        joinProjectsArr = getProyectsNotOfMember(member: actualMember!)
    }
    
    //MARK: - Obtener datos
    func getProyectsNotOfMember(member:Member)->[Project]{
        let community = getCommunityOfMember(member: member)
            var projectOfMember:[Project]=[]
            for i in 0...(community!.approvedProjects!.count-1){
                let project=community!.approvedProjects![i]
                if project.members!.contains(member.name){
                    projectOfMember.append(project)
                } else{
                    
                }
            }
            return projectOfMember
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

    //si se une al projecto debe actualizarse en miApp y enviarla en el segue de regreso    
    //MARK: - Tabla
    func numberOfSections(in tableView: UITableView) -> Int {
        return joinProjectsArr!.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = joinProjectTable.dequeueReusableCell(withIdentifier: "joinProjectCell", for: indexPath) as! JoinProjectTableViewCell
        
        let arreglo = joinProjectsArr![indexPath.section]
        
        cell.jointProjectName.text = arreglo.name
        cell.joinProjectDescription.text = arreglo.description
        cargarImagenDesdeURL(url: arreglo.imagen, imageView: cell.joinProjectImage)
        
        return cell
    }
    
    //Mantener constante el tamaño de cada celda
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250 //150 Será el tamaño para todas las tablas
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

}
