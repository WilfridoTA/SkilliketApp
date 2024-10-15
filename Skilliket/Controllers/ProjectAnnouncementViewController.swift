//
//  ProjectAnnouncementViewController.swift
//  Skilliket
//
//  Created by Will on 12/10/24.
//

import UIKit

class ProjectAnnouncementViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var announcementTable: UITableView!
    
    var ourApp:App?
    var actualMember:Member?
    var actualProject:Project?
    var announcmentsArr:[Post]?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //FALTA AGREGAR INFO Y SOBREADO A LA TABLA
        announcementTable.dataSource=self
        announcementTable.delegate=self
        
        announcmentsArr=actualProject!.announcements
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //Cada sección tendra una fila
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return announcmentsArr!.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = announcementTable.dequeueReusableCell(withIdentifier: "projectNewsCell", for: indexPath) as! ProjectAnnouncementTableViewCell
        
        let arreglo = announcmentsArr![indexPath.row]
        
        cell.projectAnnouncementDate.text = "\(arreglo.dateCreated.day)/\(arreglo.dateCreated.month)/\(arreglo.dateCreated.year)"
        
        return cell
    }

}
