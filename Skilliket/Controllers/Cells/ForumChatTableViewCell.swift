//
//  ForumChatTableViewCell.swift
//  Skilliket
//
//  Created by Astrea Polaris on 15/10/24.
//

import UIKit

class ForumChatTableViewCell: UITableViewCell {

    @IBOutlet var otherImage: UIImageView!
    
    @IBOutlet var userMessage: UILabel!
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var otherMessage: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
