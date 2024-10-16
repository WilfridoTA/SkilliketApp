//
//  ProjectCommunitiesViewController.swift
//  Skilliket
//
//  Created by Will on 12/10/24.
//

import UIKit

class ProjectCommunitiesViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var ProjectCommunitiesTable: UITableView!
    var ourApp:App?
    var actualAdmin:Admin?
    var communitiesArr:[Community]?
    var waitingProjects:[Project]?

    override func viewDidLoad() {
        super.viewDidLoad()
        ProjectCommunitiesTable.dataSource=self
        ProjectCommunitiesTable.delegate=self
        
        ProjectCommunitiesTable.layer.shadowColor = UIColor.black.cgColor
        ProjectCommunitiesTable.layer.shadowOpacity = 0.5
        ProjectCommunitiesTable.layer.shadowOffset = CGSize(width: 4, height: 4)
        ProjectCommunitiesTable.layer.shadowRadius = 6

        // Do any additional setup after loading the view.
        communitiesArr=ourApp!.communities
    }
    
    @IBAction func unwindToPostsList(undiwndSegue: UIStoryboardSegue){
        
    }
    
    //MARK: - Funciones de la tabla
    //El tamaño del arreglo nos dira el numero de secciones
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return communitiesArr!.count //Cantidad de secciones a crear
    }
    
    //Cada sección tendra exactamente una fila
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 //Cantidad de renglones a generar
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ProjectCommunitiesTable.dequeueReusableCell(withIdentifier: "projectCommunitiesCell", for: indexPath) as! ProjectCommunitiesTableViewCell
        
        //Obtenemos el tamaño de nuestro arreglo
        let commAr = communitiesArr![indexPath.section]
        
        //Modificamos el contenido de nuestra celda
        cell.projectCommunitiesName.text = commAr.name
        cell.projectCommunitiesNumToApproved.text = String(commAr.waitingProjects!.count)
        cargarImagenDesdeURL(url: commAr.image, imageView: cell.projectCommunitiesImage)

        //Personalizamos imagen
        cell.projectCommunitiesImage.layer.cornerRadius = 18
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 150 //150 Será el tamaño para todas las tablas
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
        if let nextView=segue.destination as? ProjectToBeApprovedViewController{
            nextView.ourApp=ourApp
            let index=ProjectCommunitiesTable.indexPathForSelectedRow?.row
            nextView.actualCommunity=communitiesArr![index!]
        }
    }
}
