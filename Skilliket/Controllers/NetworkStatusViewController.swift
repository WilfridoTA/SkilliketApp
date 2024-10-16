//
//  NetworkStatusViewController.swift
//  Skilliket
//
//  Created by Will on 29/09/24.
//

import UIKit

class NetworkStatusViewController: UIViewController {

    
    
    @IBOutlet var table: UITableView!
    var ourApp:App?
    var actualAdmin:Admin?
    
    @IBOutlet weak var networkBackground: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        networkBackground.layer.cornerRadius = 18
        networkBackground.layer.shadowColor = UIColor.darkGray.cgColor
        networkBackground.layer.shadowOpacity = 1
        networkBackground.layer.shadowOffset = CGSize(width: 0, height: 0)
        networkBackground.layer.shadowRadius = 10
        
        
    }
    

    //MARK: - Funciones de la tabla
    /*
    //El tamaño del arreglo nos dira el numero de secciones
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1 //Cantidad de secciones a crear
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return
    }
     */

}
