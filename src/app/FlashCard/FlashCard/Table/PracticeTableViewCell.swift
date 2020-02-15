//
//  PracticeTableViewCell.swift
//  FlashCard
//
//  Created by Hồng Mai on 2/10/20.
//  Copyright © 2020 eurecom. All rights reserved.
//

import UIKit

class PracticeTableViewCell: UITableViewCell {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    
    var originalPosition: CGPoint!
    var originalPosition1: CGPoint!
    var originalPosition2: CGPoint!
    var originalPosition3: CGPoint!
    var originalPosition4: CGPoint!
    var originalPosition5: CGPoint!
    var count = 0
    
    @IBAction func initPosition(){
        originalPosition1 = button1.center
        originalPosition2 = button2.center
        originalPosition3 = button3.center
    }
    
    @IBAction func restart(){
        button1.center = originalPosition1
        button2.center = originalPosition2
        button3.center = originalPosition3
        count = 0
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        originalPosition = sender.center
        view.bringSubviewToFront(sender)
    }
    @IBAction func buttonMoved(sender: UIButton, forEvent event: UIEvent) {
        let touches = event.allTouches
        for touch in touches!
        {
        sender.center = touch.location(in: self.viewIfLoaded)
        }
        
    }
    @IBAction func buttonReleased(_ sender: UIButton) {
        let pickerDataVisitLocation: [(btn: UIButton, img: UIImageView)] =
            [(button1, image1), (button2, image2),(button3, image3)]
        let location = pickerDataVisitLocation
        .first{ $0.btn == sender }?.img ?? image1
        if(distanceBetweenPoint(point1: sender.center, point2: location!.center) < 50) {
            sender.center = location!.center
            count += 1
        }
        else {
            UIView.animate(withDuration: 1, delay: 0.1, animations: {
                sender.center = self.originalPosition
            }, completion: { _ in})
        }
        
        if count == 5 {
            let alert = UIAlertController(title: "You are win", message: "Congratulation!", preferredStyle: UIAlertController.Style.alert)
             alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            alert.addAction(UIAlertAction(title: "Restart", style: .default, handler: { action in
                self.restart()
            }))
             
        }
    }
    private func distanceBetweenPoint(point1:CGPoint, point2:CGPoint) ->CGFloat {
        let dx: CGFloat = point2.x - point1.x
        let dy: CGFloat = point2.y - point1.y

        return sqrt(dx*dx+dy*dy)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
