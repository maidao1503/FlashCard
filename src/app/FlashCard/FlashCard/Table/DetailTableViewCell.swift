//
//  DetailTableViewCell.swift
//  FlashCard
//
//  Created by Hồng Mai on 1/29/20.
//  Copyright © 2020 eurecom. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var topicImg: UIImageView!
    @IBOutlet weak var topicLab: UILabel!
    @IBOutlet weak var topicVocal: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
