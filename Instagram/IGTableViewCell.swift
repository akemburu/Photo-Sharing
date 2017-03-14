//
//  IGTableViewCell.swift
//  Instagram
//
//  Created by Akhil  Kemburu on 8/20/16.
//  Copyright © 2016 Akhil  Kemburu. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class IGTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imageInFeed: PFImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
