//
//  ProjectToBeApprovedViewController.swift
//  Skilliket
//
//  Created by Will on 12/10/24.
//

import UIKit

class ProjectToBeApprovedViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var projectToApprovedTable: UITableView!
    var ourApp:App?
    var actualCommunity:Community?
    var projectsArr:[Project]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        projectToApprovedTable.dataSource=self
        projectToApprovedTable.delegate=self

        // Do any additional setup after loading the view.
        projectsArr=actualCommunity!.waitingProjects
    }
    
    //MARK: - Funciones de la tabla
    //El tamaño del arreglo nos dira el numero de secciones
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return projectsArr!.count //Cantidad de secciones a crear
    }
    
    //Cada sección tendra exactamente una fila
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 //Cantidad de renglones a generar
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = projectToApprovedTable.dequeueReusableCell(withIdentifier: "projectsToApproveCell", for: indexPath) as! ProjectToBeApprovedTableViewCell
        
        //Obtenemos el tamaño de nuestro arreglo
        let commAr = projectsArr![indexPath.section]
        
        //Modificamos el contenido de nuestra celda
        cell.projectApprovedName.text = commAr.name
        cell.projectApprovedContent.text = commAr.description
        cargarImagenDesdeURL(url: commAr.imagen, imageView: cell.projectApprovedImage)

        //Personalizamos imagen
        cell.projectApprovedImage.layer.cornerRadius = 18
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextView=segue.destination as? ProjectApprovedDetailsViewController{
            nextView.ourApp=ourApp
            let index=projectToApprovedTable.indexPathForSelectedRow?.row
            nextView.actualProject=projectsArr![index!]
        }
    }
    
    @IBAction func unwindToProjectToBeApprovedViewController(undiwndSegue: UIStoryboardSegue){
        
    }

}
