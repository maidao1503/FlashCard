//
//  CardViewController.swift
//  FlashCard
//
//  Created by Hồng Mai on 1/9/20.
//  Copyright © 2020 eurecom. All rights reserved.
//

import UIKit
import AVFoundation

class CardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var id = 1
    var label = "Animal"
    var audioPlayer = AVAudioPlayer()
    
    @IBOutlet weak var topicLab: UILabel!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let cards = Card.getCardsByTid(tid: Int16(id))
        let num = cards.count
        return num
    }
    
    let identifier_table = "cardTableViewCell"
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.identifier_table, for: indexPath ) as! CardTableViewCell
        
        cell.layer.masksToBounds = true
        cell.layer.borderWidth = 10
        cell.layer.shadowOffset = CGSize(width: -1, height: 1)
        //cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.backgroundColor = UIColor.white.cgColor
        let cards = Card.getCardsByTid(tid: Int16(id))
        cell.cardLab.text = cards[indexPath.item].vocal
        cell.cardImg.image = UIImage(named: cards[indexPath.item].img)
        cell.cardNote.text = cards[indexPath.item].note
        cell.audio = cards[indexPath.item].vocal
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
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
