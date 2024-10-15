//
//  PostsTableViewController.swift
//  Skilliket
//
//  Created by Will on 29/09/24.
//

//ESTE ARCHIVO FUE CREADO PARA PROBAR LAS FUNCIONALIDADES DE ADMIN
//              NO USAR EN LA ENTREGA FINAL

import UIKit

class PostsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Cargar info en la tabla
        tableView.dataSource = self//La misma clase será encargada de obtener la información de la celda
        tableView.delegate = self//Tamaño de celda - UITableViewDelegate
        
        //Personalizamos las celdas generadas
        tableView.layer.shadowColor = UIColor.black.cgColor
        tableView.layer.shadowOpacity = 0.5
        tableView.layer.shadowOffset = CGSize(width: 4, height: 4)
        tableView.layer.shadowRadius = 6
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return communitiesArr.count //Cantidad de secciones a crear
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1 //Cantidad de renglones a generar
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostsCell", for: indexPath) as! PostsTableViewCell

        //Obtenemos el tamaño del arreglo
        let commAr = communitiesArr[indexPath.row]
        
        //Modificamos valores de nuestra celda
        
        cell.CommunityName.text = commAr.name
        cell.PostsNumber.text = String(commAr.projects.count)
        cell.CommunityImage.image = UIImage(named: commAr.image)

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
