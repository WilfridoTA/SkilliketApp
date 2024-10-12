//
//  YourProjectsViewController.swift
//  Skilliket
//
//  Created by Will on 12/10/24.
//

import UIKit

class YourProjectsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var yourProjectsTable: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //Cargar info en la tabla
        yourProjectsTable.dataSource = self//La misma clase será encargada de obtener la información de la celda
        yourProjectsTable.delegate = self//Tamaño de celda - UITableViewDelegate
    }
    
    //MARK: - Funciones de la tabla
    //El tamaño del arreglo nos dira el numero de secciones
    func numberOfSections(in tableView: UITableView) -> Int {
        return communitiesArr.count
    }
    
    //Cada sección tendra una fila
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = yourProjectsTable.dequeueReusableCell(withIdentifier: "UserProjectCell", for: indexPath) as! YourProjectsTableViewCell
        
        let arreglo = communitiesArr[indexPath.row]
        
        cell.yourProjectsName.text = arreglo.name
        
        return cell
    }
    
    //Mantener constante el tamaño de cada celda
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250 //150 Será el tamaño para todas las tablas
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
