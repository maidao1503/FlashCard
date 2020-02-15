//
//  ViewController.swift
//  FlashCard
//
//  Created by Hồng Mai on 11/25/19.
//  Copyright © 2019 eurecom. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    let identifier = "topicCollection"
    var temp = 0
    let identifier_table = "mainTableViewCell"
    let topicArr = [1, 3, 6, 9, 1]
    let myTopicArr = [4, 2, 8, 9, 1]
    let recomArr = [3, 7, 9, 1, 1]
    let libraryArr = [9, 4, 3, 6, 8]
    let topicsArr = [[1, 3, 6, 9, 1], [4, 2, 8], [3, 7], [9, 4, 3, 6, 8, 1]]
    var storedOffsets = [Int: CGFloat]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.identifier_table, for: indexPath ) as! MainTableViewCell
        
        self.temp = indexPath.row
        switch indexPath.row
        {
        //
        case 0:
            cell.topicLabel.text = "Recent Learning"
        case 1:
            cell.topicLabel.text = "My Topics"
        case 2:
            cell.topicLabel.text = "Library"
        case 3:
            cell.topicLabel.text = "Recommendation"
        default:
            break;
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        guard let tableViewCell = cell as? MainTableViewCell else { return }

        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
        tableViewCell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
    }

    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        guard let tableViewCell = cell as? MainTableViewCell else { return }

        storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topicsArr[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.identifier, for: indexPath ) as! TopicCollectionViewCell
        
        let topic = Topic.getTopicById(id: Int16(topicsArr[collectionView.tag][indexPath.item]))
        
        cell.topicImg.image = UIImage(named: topic.first?.topicImg ?? "")
        cell.topicLab.text = topic.first?.topicLab ?? ""
        return cell
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        Card.deleteAllCard()
        Topic.deleteAllTopic()
        addData()        
        self.view.backgroundColor = UIColor.black
        
    }
    
    func addData() {
        var topic = Topic.insertNewTopic(id: 1, topicImg: "animal", topicLab: "Animal")
        topic = Topic.insertNewTopic(id: 2, topicImg: "number", topicLab: "Number")
        topic = Topic.insertNewTopic(id: 3, topicImg: "time", topicLab: "Time")
        topic = Topic.insertNewTopic(id: 4, topicImg: "food", topicLab: "Food")
        topic = Topic.insertNewTopic(id: 5, topicImg: "school", topicLab: "School")
        topic = Topic.insertNewTopic(id: 6, topicImg: "music", topicLab: "Music")
        topic = Topic.insertNewTopic(id: 7, topicImg: "nature", topicLab: "Nature")
        topic = Topic.insertNewTopic(id: 8, topicImg: "world", topicLab: "World")
        topic = Topic.insertNewTopic(id: 9, topicImg: "colours", topicLab: "Colours")
        var card = Card.insertNewCard(id: 1, img: "dog", tid: 1, vocal: "Dog", note: "[ˈdɒɡ]\n(male or female) chien(ne) m/f")
        card = Card.insertNewCard(id: 2, img: "cat", tid: 1, vocal: "Cat", note: "[ˈkæt]\r\n (domestic) chat m")
        card = Card.insertNewCard(id: 3, img: "one", tid: 2, vocal: "One", note: "[ˈwʌn]\r\n un(e)\r\n one minute une minute")
        card = Card.insertNewCard(id: 4, img: "two", tid: 2, vocal: "Two", note: "[ˈtuː]\r\n deux \r\nShe’s two. Elle a deux ans.")
        card = Card.insertNewCard(id: 5, img: "butterfly", tid: 1, vocal: "Butterfly", note: "[ˈbʌtəʳflaɪ]\r\n Papillon m")
        card = Card.insertNewCard(id: 6, img: "pig", tid: 1, vocal: "Pig", note: "[ˈpɪɡ]\r\n cochon m ⧫ porc m")
        card = Card.insertNewCard(id: 7, img: "three", tid: 2, vocal: "Three", note: "[ˈθriː]\r\n trois\r\nShe’s three. Elle a trois ans.")
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let desVC = mainStoryboard.instantiateViewController(identifier: "DetailViewController") as! DetailViewController
        desVC.id = topicsArr[collectionView.tag][indexPath.item]
        self.navigationController?.pushViewController(desVC, animated: true)
    }



}

