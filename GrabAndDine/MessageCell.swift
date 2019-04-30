//
//  MessageCell.swift
//  GrabAndDine
//
//  Created by Sheng Liu on 4/30/19.
//  Copyright © 2019 rachelchen0418. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var selfMessageImage: UIImageView!
    @IBOutlet weak var userMessageImage: UIImageView!
    @IBOutlet weak var userMessageLabel: UILabel!
    @IBOutlet weak var selfMessageLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
