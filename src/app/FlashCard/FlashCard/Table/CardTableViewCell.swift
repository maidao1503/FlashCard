//
//  CardTableViewCell.swift
//  FlashCard
//
//  Created by Hồng Mai on 1/30/20.
//  Copyright © 2020 eurecom. All rights reserved.
//

import UIKit
import AVFoundation

class CardTableViewCell: UITableViewCell {

    @IBOutlet weak var cardNote: UILabel!
    @IBOutlet weak var cardLab: UILabel!
    @IBOutlet weak var cardImg: UIImageView!
    @IBOutlet weak var cardAud: UIButton!
    var audio = ""
    var audioPlayer = AVAudioPlayer()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func speakVocab(_ sender: Any) {
        let backgroundMusic = NSURL(fileURLWithPath: Bundle.main.path(forResource: audio, ofType: "m4a")!)
        audioPlayer = try! AVAudioPlayer(contentsOf: backgroundMusic as URL)
        audioPlayer.play()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
