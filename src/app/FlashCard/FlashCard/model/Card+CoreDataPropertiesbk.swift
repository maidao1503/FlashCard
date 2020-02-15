//
//  Card+CoreDataProperties.swift
//  FlashCard
//
//  Created by Hồng Mai on 2/1/20.
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
    @NSManaged public var img: String?
    @NSManaged public var tid: Int16
    @NSManaged public var vocal: String?
    @NSManaged public var topic: Topic?
    @NSManaged public var note: String?
    
    static func insertNewCard(id: Int16, img: String, tid: Int16, vocal: String, note: String) -> Card? {
        let card = NSEntityDescription.insertNewObject(forEntityName: "Card", into: AppDelegate.managedObjectContext!) as! Card
        card.id = id
        card.tid = tid
        card.vocal = vocal
        card.note = note
        do {
            try AppDelegate.managedObjectContext?.save()
        } catch  {
            return nil
        }
        return card
    }
}
