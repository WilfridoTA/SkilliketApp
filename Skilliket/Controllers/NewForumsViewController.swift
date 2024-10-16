//
//  NewForumsViewController.swift
//  Skilliket
//
//  Created by Will on 11/10/24.
//

import UIKit

class NewForumsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var featuredForumsTable: UITableView!
    
    var ourApp:App?
    var actualMember:Member?
    var actualCommunity:Community?
    var forumsArr:[Forum]?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let navigationController = self.navigationController {
            navigationController.setNavigationBarHidden(false, animated: true)
        }
        
        featuredForumsTable.dataSource=self
        featuredForumsTable.delegate=self
        
        //Para cada celda
        featuredForumsTable.layer.shadowColor = UIColor.black.cgColor
        featuredForumsTable.layer.shadowOpacity = 0.5
        featuredForumsTable.layer.shadowOffset = CGSize(width: 4, height: 4)
        featuredForumsTable.layer.shadowRadius = 6
        
        forumsArr=getForumsNotWithMember(member: actualMember!)
        if forumsArr!.count==0{
            showAlert(title: "Hey!", message: "Seems like you have joined to all the available forums of your community")
        }
        
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
    
    func getForumsNotWithMember(member: Member)->[Forum]?{
        var forumNoMember:[Forum]=[]
        for i in 0...(actualCommunity!.forums!.count-1){
            let forum=actualCommunity!.forums![i]
            if forum.members!.contains(member.name){
            } else{
                forumNoMember.append(forum)
            }
        }
        return forumNoMember
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: - Celdas de la tabla
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return forumsArr!.count //Cantidad de secciones a crear
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = featuredForumsTable.dequeueReusableCell(withIdentifier: "featuredForumsCell", for: indexPath) as! FeaturedForumsTableViewCell
        
        //Obtenemos el tamaño del arreglo de proyectos
        let forArr = forumsArr![indexPath.section]
        cell.featuredFormsDescription.text=forArr.description
        cell.featuredForumsLocation.text=forArr.location
        cell.featuredForumsName.text=forArr.name
        cell.featuredForumsNumMembers.text="\(forumsArr!.count)"
        cargarImagenDesdeURL(url: forArr.image, imageView: cell.featuredForumsImage)
        
        //Bordear imagen
        cell.featuredForumsImage.layer.cornerRadius = 18
        
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

}
