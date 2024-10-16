//
//  PostApproveViewController.swift
//  Skilliket
//
//  Created by Will on 29/09/24.
//

import UIKit

class PostApproveViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var postApproveTable: UITableView!
    var ourApp:App?
    var actualAdmin:Admin?
    var actualCommunity:Community?
    var postsArr:[Any]?

    override func viewDidLoad() {
        super.viewDidLoad()

        //Cargar info en la tabla
        postApproveTable.dataSource = self//La misma clase será encargada de obtener la información de la celda
        postApproveTable.delegate = self//Tamaño de celda - UITableViewDelegate
        
        //Personalizamos las celdas generadas
        postApproveTable.layer.shadowColor = UIColor.black.cgColor
        postApproveTable.layer.shadowOpacity = 0.5
        postApproveTable.layer.shadowOffset = CGSize(width: 4, height: 4)
        postApproveTable.layer.shadowRadius = 6
        postsArr=getWaitingContentsOfCommunity(community: actualCommunity!)
    }
    
    @IBAction func unwindToPostApproveViewController(_ segue: UIStoryboardSegue) {
        }
    
    
    //MARK: - Funciones de la tabla
    
    //El tamaño del arreglo nos dira el numero de secciones
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return postsArr!.count //Cantidad de secciones a crear
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = postApproveTable.dequeueReusableCell(withIdentifier: "projectsApproveCell", for: indexPath) as! PostApproveTableViewCell
        
        //Obtenemos el tamaño del arreglo de proyectos
        let postArr = postsArr![indexPath.section]
        
        //Contenido de cada celda
        if let posts = postArr as? [Skilliket.Post] {
            for p in posts {
                cell.postApproveTitle.text = "Post by \(p.creator)"
                cell.postApproveContent.text = p.text
                if let im = p.image {
                    cargarImagenDesdeURL(url: im, imageView: cell.postApproveImage)
                } else {
                    cell.postApproveImage.image = UIImage(systemName: ".square.and.pencil.circle")
                }
            }
        } else if let news = postArr as? [Skilliket.New] {
            for p in news {
                cell.postApproveTitle.text = "Post by \(p.creator)"
                cell.postApproveContent.text = "\(p.text) \nLink: \(p.link)"
            }
        } else {
            print("Tipo desconocido en postArr")
        }

        
        
        //Personalizar la imagen
        cell.postApproveImage.layer.cornerRadius = 9
        
        return cell
    }
    
    func getWaitingContentsOfCommunity(community:Community)->[Any]{
        //te da todos los contenidos (posts, news y reports) de una comunidad
        var contents:[Any]=[]
        contents.append(community.waitingPost)
        contents.append(community.waitingNews)
        
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
    
    //Mantener constante el tamaño de cada celda
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300 //150 Será el tamaño para todas las tablas
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
        if let nextView=segue.destination as? SelectedPostViewController{
            nextView.ourApp=ourApp
            nextView.actualAdmin=actualAdmin
            nextView.actualCommunity=actualCommunity
            let index=postApproveTable.indexPathForSelectedRow?.row
            nextView.actualPost=postsArr![index!]
        }
    }
}
