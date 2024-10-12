//
//  CommunitiesViewController.swift
//  Skilliket
//
//  Created by Will on 27/09/24.
//

import UIKit

class CommunitiesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var communitiesTable: UITableView!
    
    //Aquí estaba el contenido de communities.swift
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Cargar info en la tabla
        communitiesTable.dataSource = self//La misma clase será encargada de obtener la información de la celda
        communitiesTable.delegate = self//Tamaño de celda - UITableViewDelegate
        
        //Personalizamos las celdas generadas
        communitiesTable.layer.shadowColor = UIColor.black.cgColor
        communitiesTable.layer.shadowOpacity = 0.5
        communitiesTable.layer.shadowOffset = CGSize(width: 4, height: 4)
        communitiesTable.layer.shadowRadius = 6
    }
    
    
    //MARK: - Funciones de la tabla
    //El tamaño del arreglo nos dira el numero de secciones
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return communitiesArr.count //Cantidad de secciones a crear
    }
    
    //Cada sección tendra exactamente una fila
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 //Cantidad de renglones a generar
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = communitiesTable.dequeueReusableCell(withIdentifier: "communitiesCell", for: indexPath) as! CommunitiesTableViewCell
        
        //Obtenemos el tamaño de nuestro arreglo
        let commAr = communitiesArr[indexPath.row]
        
        //Modificamos los valores del contenido de nuestra celda
        cell.communityName.text = commAr.name
        cell.CommunityLocation.text = commAr.location
        cell.CommunityImage.image = UIImage(named: commAr.image)
        
        //Personalizamos imagen
        cell.CommunityImage.layer.cornerRadius = 18
        
        return cell
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

}
