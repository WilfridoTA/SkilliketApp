//
//  YourProjectsViewController.swift
//  Skilliket
//
//  Created by Will on 12/10/24.
//

import UIKit

class YourProjectsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var ourApp:App?
    var actualMember:Member?
    var projectsArr:[Project]?
    
    @IBOutlet weak var yourProjectsTable: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //Cargar info en la tabla
        yourProjectsTable.dataSource = self//La misma clase será encargada de obtener la información de la celda
        yourProjectsTable.delegate = self//Tamaño de celda - UITableViewDelegate
        
        projectsArr=getProyectsOfMember(member: actualMember!)
    }
    
    func getProyectsOfMember(member:Member)->[Project]{
        //da todos los proyectos APROVADOS en los que participa un member (como creador o solo participante)
        let community=getCommunityOfMember(member: member)
        var projectOfMember:[Project]=[]
        for i in 0...(community!.approvedProjects!.count-1){
            let project=community!.approvedProjects![i]
            if project.members!.contains(member.name){
                projectOfMember.append(project)
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
    
    //MARK: - Funciones de la tabla
    //El tamaño del arreglo nos dira el numero de secciones
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //Cada sección tendra una fila
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projectsArr!.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = yourProjectsTable.dequeueReusableCell(withIdentifier: "UserProjectCell", for: indexPath) as! YourProjectsTableViewCell
        
        let arreglo = projectsArr![indexPath.row]
        
        cell.yourProjectsName.text = arreglo.name
        cell.yourProjectsDescription.text=arreglo.description
        cargarImagenDesdeURL(url: arreglo.imagen, imageView: cell.YourProjectsImage)
        
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
        return 250 //150 Será el tamaño para todas las tablas
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextView=segue.destination as? ProjectNewsViewController{
            nextView.ourApp=ourApp
            nextView.actualMember=actualMember
            let index=yourProjectsTable.indexPathForSelectedRow?.row
            nextView.actualProject=projectsArr![index!]
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

}
