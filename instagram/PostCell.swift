//
//  PostCell.swift
//  instagram
//
//  Created by Vibhu Appalaraju on 10/3/18.
//  Copyright © 2018 Vibhu Appalaraju. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var instaCaptionLabel: UILabel!
    @IBOutlet weak var instaImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
