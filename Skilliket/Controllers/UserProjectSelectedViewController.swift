//
//  UserProjectSelectedViewController.swift
//  Skilliket
//
//  Created by Will on 12/10/24.
//

import UIKit

class UserProjectSelectedViewController: UIViewController {

    @IBOutlet weak var viewContainer: UIView!
    
    //Para guardar las otras vistas
    var views: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Inicializamos las vistas
        views = [UIView]()
        views.append(ProjectNewsViewController().view)
        views.append(ProjectChatViewController().view)
        views.append(ProjectAnnouncementsViewController().view)
        
        for v in views{
            viewContainer.addSubview(v)
        }
        viewContainer.bringSubviewToFront(views[0])
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func switchView(_ sender: UISegmentedControl) {
        self.viewContainer.bringSubviewToFront(views[sender.selectedSegmentIndex])
    }
    
}
