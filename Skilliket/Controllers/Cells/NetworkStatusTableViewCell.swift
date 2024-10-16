//
//  NetworkStatusTableViewCell.swift
//  Skilliket
//
//  Created by Astrea Polaris on 15/10/24.
//

import UIKit

class NetworkStatusTableViewCell: UITableViewCell {

    @IBOutlet var statusImage: UIImageView!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var deviceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
