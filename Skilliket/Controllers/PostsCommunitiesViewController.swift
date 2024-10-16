//
//  PostsCommunitiesViewController.swift
//  Skilliket
//
//  Created by Will on 29/09/24.
//

import UIKit

class PostsCommunitiesViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    var ourApp:App?
    var actualAdmin:Admin?
    var communitiesArr:[Community?]?
    var actualCommunity:Community?
    
    @IBOutlet weak var postsCommunitiesTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Cargar info en la tabla
        postsCommunitiesTable.dataSource = self//La misma clase será encargada de obtener la información de la celda
        postsCommunitiesTable.delegate = self//Tamaño de celda - UITableViewDelegate
        
        //Personalizamos las celdas generadas
        postsCommunitiesTable.layer.shadowColor = UIColor.black.cgColor
        postsCommunitiesTable.layer.shadowOpacity = 0.5
        postsCommunitiesTable.layer.shadowOffset = CGSize(width: 4, height: 4)
        postsCommunitiesTable.layer.shadowRadius = 6
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
        let cell = postsCommunitiesTable.dequeueReusableCell(withIdentifier: "postsCommunitiesCell", for: indexPath) as! PostsTableViewCell
        
        //Obtenemos el tamaño de nuestro arreglo
        let commAr = communitiesArr![indexPath.section]
        
        //Modificamos el contenido de nuestra celda
        cell.CommunityName.text = commAr!.name
        cell.PostsNumber.text = String(commAr!.waitingProjects!.count)
        cargarImagenDesdeURL(url: commAr!.image, imageView: cell.CommunityImage)

        //Personalizamos imagen
        cell.CommunityImage.layer.cornerRadius = 18
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
        return 150 //150 Será el tamaño para todas las tablas
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
        if let nextView=segue.destination as? PostApproveViewController{
            nextView.ourApp=ourApp
            nextView.actualAdmin=actualAdmin
            let index=postsCommunitiesTable.indexPathForSelectedRow?.row
            nextView.actualCommunity=communitiesArr![index!]
        }
    }
}
