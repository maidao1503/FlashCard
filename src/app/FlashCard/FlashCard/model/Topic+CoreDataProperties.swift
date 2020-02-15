//
//  Topic+CoreDataProperties.swift
//  FlashCard
//
//  Created by Hồng Mai on 2/8/20.
//  Copyright © 2020 eurecom. All rights reserved.
//
//

import Foundation
import CoreData


extension Topic {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Topic> {
        return NSFetchRequest<Topic>(entityName: "Topic")
    }

    @NSManaged public var id: Int16
    @NSManaged public var topicImg: String?
    @NSManaged public var topicLab: String?
    @NSManaged public var fk_cards: Set<Card>

}

// MARK: Generated accessors for fk_topic
extension Topic {

    @objc(addFk_topicObject:)
    @NSManaged public func addToFk_topic(_ value: Card)

    @objc(removeFk_topicObject:)
    @NSManaged public func removeFromFk_topic(_ value: Card)

    @objc(addFk_topic:)
    @NSManaged public func addToFk_topic(_ values: Set<Card>)

    @objc(removeFk_topic:)
    @NSManaged public func removeFromFk_topic(_ values: Set<Card>)

    static func insertNewTopic(id: Int16, topicImg: String, topicLab: String) -> Topic? {
        let topic = NSEntityDescription.insertNewObject(forEntityName: "Topic", into: AppDelegate.managedObjectContext!) as! Topic
        topic.id = id
        topic.topicImg = topicImg
        topic.topicLab = topicLab
        do {
            try AppDelegate.managedObjectContext?.save()
        } catch  {
            return nil
        }
        return topic
    }
    
    static func getAllTopics() -> [Topic] {
        var result = [Topic]()
        let moc = AppDelegate.managedObjectContext
        do {
            result = try moc!.fetch(Topic.fetchRequest()) as! [Topic]
        } catch {
            print("Can not fetch topic.Error \(error)")
            return result
        }
        return result
    }
    
    static func getTopicById(id: Int16) -> [Topic] {
        var result = [Topic]()
        let moc = AppDelegate.managedObjectContext
        // Create Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Topic")
        // Add Predicate
        let predicate = NSPredicate(format: "id = %d", id)
        fetchRequest.predicate = predicate

        do {
            result = try moc!.fetch(fetchRequest) as! [Topic]

        } catch {
            print(error)
        }
        return result
    }
    
    static func getVocalById(id: Int16) -> String {
        var cards = [Card]()
        var result = String()
        let moc = AppDelegate.managedObjectContext
        // Create Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Card")
        // Add Predicate
        let predicate = NSPredicate(format: "tid = %d", id)
        fetchRequest.predicate = predicate

        do {
            cards = try moc!.fetch(fetchRequest) as! [Card]
            for (idx, card) in cards.enumerated() {
                if idx == cards.endIndex-1 {
                    result += "\(card.vocal ?? "")"
                }
                else {
                    if (card.vocal != "") {
                        result += "\(card.vocal ?? "") - "
                    }
                     
                }
            }
        } catch {
            print(error)
        }
        return result
    }
    
    static func deleteAllTopic() -> Bool {
        let moc = AppDelegate.managedObjectContext
        let topics = Topic.getAllTopics()
        for topic in topics {
            moc?.delete(topic)
        }
        do {
            try AppDelegate.managedObjectContext?.save()
        } catch {
            let nserror = error as NSError
            print("Delete All Topic fail. Error: \(nserror), \(nserror.userInfo)")
            return false
        }
        return true
    }
}
