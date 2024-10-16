//
//  ProjectNewsViewController.swift
//  Skilliket
//
//  Created by Will on 12/10/24.
//

import UIKit

class ProjectNewsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var ourApp:App?
    var actualMember:Member?
    var actualProject:Project?
    var newsArr:[New]?
    
    @IBOutlet weak var projectNewsTable: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        projectNewsTable.dataSource=self
        projectNewsTable.delegate=self
        newsArr=actualProject!.news
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //Cada sección tendra una fila
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArr!.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = projectNewsTable.dequeueReusableCell(withIdentifier: "projectNewsCell", for: indexPath) as! ProjectNewsTableViewCell
        
        let arreglo = newsArr![indexPath.section]
        
        cell.projectNewsDescripcion.text=arreglo.text
        cell.projectNewsEnlace.text="\(arreglo.link)"
        cell.projectNewsDate.text = "\(arreglo.dateCreated.day!)/\(arreglo.dateCreated.month!)/\(arreglo.dateCreated.year!)"
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextView=segue.destination as? ProjectAnnouncementViewController{
            nextView.ourApp=ourApp
            nextView.actualMember=actualMember
            nextView.actualProject=actualProject
        }
    }

}
