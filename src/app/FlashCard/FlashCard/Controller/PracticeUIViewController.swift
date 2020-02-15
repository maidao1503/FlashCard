//
//  PracticeUIViewController.swift
//  FlashCard
//
//  Created by Hồng Mai on 2/10/20.
//  Copyright © 2020 eurecom. All rights reserved.
//

import UIKit
import CoreData

class PracticeUIViewController: UIViewController {
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image_1: UIImageView!
    @IBOutlet weak var image_2: UIImageView!
    @IBOutlet weak var image_3: UIImageView!
    @IBOutlet weak var topicLab: UILabel!
    
    var originalPosition: CGPoint!
    var originalPosition1: CGPoint!
    var originalPosition2: CGPoint!
    var originalPosition3: CGPoint!
    var originalPosition4: CGPoint!
    var originalPosition5: CGPoint!
    var count = 0
    var id = 1
    var label = ""
   
    
    @IBAction func initPosition(){
        let cards = Card.getCardsByTid(tid: Int16(id))
        let num = cards.count - 1
        var numbers = Array(0...num)
        let shuffledNumbers = numbers.shuffled()
        print("maimai\(numbers), - \(num)")
        numbers.shuffle()
        print("maimai\(numbers)")
        
        
        button1.setTitle(cards[numbers[0]].vocal, for: .normal)
        button2.setTitle(cards[numbers[1]].vocal, for: .normal)
        button3.setTitle(cards[numbers[2]].vocal, for: .normal)
        image_1.image = UIImage(named: cards[numbers[0]].img)
        image_2.image = UIImage(named: cards[numbers[1]].img)
        image_3.image = UIImage(named: cards[numbers[2]].img)
        
        originalPosition1 = button1.center
        originalPosition2 = button2.center
        originalPosition3 = button3.center
    }
    
    @IBAction func restart(){
        let cards = Card.getCardsByTid(tid: Int16(id))
        let num = cards.count - 1
        var numbers = Array(0...num)
        let shuffledNumbers = numbers.shuffled()
        numbers.shuffle()
        print("maimai\(numbers)")
        
        
        button1.setTitle(cards[numbers[0]].vocal, for: .normal)
        button2.setTitle(cards[numbers[1]].vocal, for: .normal)
        button3.setTitle(cards[numbers[2]].vocal, for: .normal)
        image_1.image = UIImage(named: cards[numbers[0]].img)
        image_2.image = UIImage(named: cards[numbers[1]].img)
        image_3.image = UIImage(named: cards[numbers[2]].img)
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
        
        if count == 3 {
            let alert = UIAlertController(title: "You are win", message: "Congratulation!", preferredStyle: UIAlertController.Style.alert)
             alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            alert.addAction(UIAlertAction(title: "Next", style: .default, handler: { action in
                self.restart()
            }))
             
        }
    }
    private func distanceBetweenPoint(point1:CGPoint, point2:CGPoint) ->CGFloat {
        let dx: CGFloat = point2.x - point1.x
        let dy: CGFloat = point2.y - point1.y

        return sqrt(dx*dx+dy*dy)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initPosition()
        topicLab.text = label
        
        
        // Do any additional setup after loading the view.
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
