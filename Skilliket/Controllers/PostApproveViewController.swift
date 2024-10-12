//
//  PostApproveViewController.swift
//  Skilliket
//
//  Created by Will on 29/09/24.
//

import UIKit

class PostApproveViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var postApproveTable: UITableView!
    

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
    }
    
    
    //MARK: - Funciones de la tabla
    
    //El tamaño del arreglo nos dira el numero de secciones
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return projectsArr.count //Cantidad de secciones a crear
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = postApproveTable.dequeueReusableCell(withIdentifier: "projectsApproveCell", for: indexPath) as! PostApproveTableViewCell
        
        //Obtenemos el tamaño del arreglo de proyectos
        let projArr = projectsArr[indexPath.row]
        
        //Contenido de cada celda
        cell.postApproveTitle.text = projArr.projectName
        cell.postApproveContent.text = projArr.projectDescription
        cell.postApproveImage.image = UIImage(named: projArr.projImage)
        
        //Personalizar la imagen
        cell.postApproveImage.layer.cornerRadius = 9
        
        return cell
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

}
