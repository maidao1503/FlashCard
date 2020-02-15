//
//  Topic+CoreDataProperties.swift
//  FlashCard
//
//  Created by Hồng Mai on 2/1/20.
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
    @NSManaged public var cards: Set<Card>

}

// MARK: Generated accessors for topic
extension Topic {

    @objc(addTopicObject:)
    @NSManaged public func addToTopic(_ value: Card)

    @objc(removeTopicObject:)
    @NSManaged public func removeFromTopic(_ value: Card)

    @objc(addTopic:)
    @NSManaged public func addToTopic(_ values: NSSet)

    @objc(removeTopic:)
    @NSManaged public func removeFromTopic(_ values: NSSet)

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
}
