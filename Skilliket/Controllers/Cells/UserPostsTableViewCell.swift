//
//  UserPostsTableViewCell.swift
//  Skilliket
//
//  Created by Astrea Polaris on 01/10/24.
//

import UIKit

class UserPostsTableViewCell:
                                    
    UITableViewCell {
    @IBOutlet var imagePost: UIImageView!
    
    @IBOutlet var link: UILabel!
    @IBOutlet var descriptionPost: UILabel!
    @IBOutlet var title: UILabel!
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var timeTypeLabel: UILabel!
    @IBOutlet var nameMember: UILabel!
}
