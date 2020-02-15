//
//  Card+CoreDataProperties.swift
//  FlashCard
//
//  Created by Hồng Mai on 2/8/20.
//  Copyright © 2020 eurecom. All rights reserved.
//
//

import Foundation
import CoreData


extension Card {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Card> {
        return NSFetchRequest<Card>(entityName: "Card")
    }

    @NSManaged public var id: Int16
    @NSManaged public var img: String
    @NSManaged public var note: String
    @NSManaged public var tid: Int16
    @NSManaged public var vocal: String
    @NSManaged public var fk_topic: Topic?
    
    static func insertNewCard(id: Int16, img: String, tid: Int16, vocal: String, note: String) -> Card? {
        let card = NSEntityDescription.insertNewObject(forEntityName: "Card", into: AppDelegate.managedObjectContext!) as! Card
        card.id = id
        card.tid = tid
        card.vocal = vocal
        card.img = img
        card.note = note
        do {
            try AppDelegate.managedObjectContext?.save()
        } catch  {
            return nil
        }
        return card
    }
    
    static func getCardById(id: Int16) -> [Card] {
        var result = [Card]()
        let moc = AppDelegate.managedObjectContext
        // Create Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Card")
        // Add Predicate
        let predicate = NSPredicate(format: "id = %d", id)
        fetchRequest.predicate = predicate

        do {
            result = try moc!.fetch(fetchRequest) as! [Card]

        } catch {
            print(error)
        }
        return result
    }
    
    static func getCardsByTid(tid: Int16) -> [Card] {
        var result = [Card]()
        let moc = AppDelegate.managedObjectContext
        // Create Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Card")
        // Add Predicate
        let predicate = NSPredicate(format: "tid = %d", tid)
        fetchRequest.predicate = predicate

        do {
            result = try moc!.fetch(fetchRequest) as! [Card]

        } catch {
            print(error)
        }
        return result
    }
    
    static func getAllCards() -> [Card] {
        var result = [Card]()
        let moc = AppDelegate.managedObjectContext
        do {
            result = try moc!.fetch(Card.fetchRequest()) as! [Card]
            for card in result {
                print("maimai: id-\(card.id),vol-\(card.vocal ?? "abc"), tid-\(card.tid),img-\(card.img),note-\(card.note)")
            }
        } catch {
            print("Can not fetch topic.Error \(error)")
            return result
        }
        return result
    }
    
    static func deleteAllCard() -> Bool {
        let moc = AppDelegate.managedObjectContext
        let cards = Card.getAllCards()
        for card in cards {
            moc?.delete(card)
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
