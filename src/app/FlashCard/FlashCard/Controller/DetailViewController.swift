//
//  DetailViewController.swift
//  FlashCard
//
//  Created by Hồng Mai on 1/9/20.
//  Copyright © 2020 eurecom. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var label = ""
    var vocal = ""
    var id = 1
    let identifier_table = "DetailTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.identifier_table, for: indexPath ) as! DetailTableViewCell
        let topic = Topic.getTopicById(id: Int16(id))
        if let image:UIImage? =  UIImage(named: topic.first!.topicImg!) {
        //if topic.first!.topicImg != nil {
            cell.topicImg.image = image
        }
        cell.topicLab.text = topic.first!.topicLab
        cell.topicVocal.text = Topic.getVocalById(id: Int16(id))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "cardDetail", sender: self)
        performSegue(withIdentifier: "practice", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let destination = segue.destination as? CardViewController
        let practice = segue.destination as? PracticeUIViewController

        if segue.identifier == "cardDetail" {
            let topic = Topic.getTopicById(id: Int16(id))
            destination?.id = id
            destination?.label = topic.first!.topicLab!
        }else if segue.identifier == "practice" {
            let topic1 = Topic.getTopicById(id: Int16(id))
            practice?.id = id
            practice?.label = topic1.first!.topicLab!
        }
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
