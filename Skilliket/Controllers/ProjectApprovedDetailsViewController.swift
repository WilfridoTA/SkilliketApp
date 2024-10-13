//
//  ProjectApprovedDetailsViewController.swift
//  Skilliket
//
//  Created by Will on 13/10/24.
//

import UIKit

class ProjectApprovedDetailsViewController: UIViewController {
    
    @IBOutlet weak var projectApprovedBackground: UIView!
    @IBOutlet weak var projectDetailsApproved: UIButton!
    @IBOutlet weak var projectDetailsDiscard: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Personalizamos el fondo
        projectApprovedBackground.layer.cornerRadius = 18
        projectApprovedBackground.layer.shadowColor = UIColor.black.cgColor
        projectApprovedBackground.layer.shadowOpacity = 0.5
        projectApprovedBackground.layer.shadowOffset = CGSize(width: 4, height: 4)
        projectApprovedBackground.layer.shadowRadius = 6
        
        //Personalizamos los botones
        projectDetailsApproved.layer.cornerRadius = 18
        projectDetailsDiscard.layer.cornerRadius = 18
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
