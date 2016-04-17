//
//  CoreDataHelpers.swift
//  Taskability
//
//  Created by Connor Krupp on 16/04/2016.
//  Copyright © 2016 Connor Krupp. All rights reserved.
//

import Foundation
import CoreData

public class TaskabilityCoreData {
    public class func initializeFetchedResultsController(withFetchRequest fetchRequest: NSFetchRequest,
                                                             inManagedObjectContext managedObjectContext: NSManagedObjectContext) -> NSFetchedResultsController {

        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                  managedObjectContext: managedObjectContext,
                                                                  sectionNameKeyPath: nil, cacheName: nil)

        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Failed to initialize fetchedResultsController")
        }
        
        return fetchedResultsController
    }

    public class func insertTaskGroupWithTitle(title: String, inManagedObjectContext managedObjectContext: NSManagedObjectContext) -> TaskGroup {

        let item = NSEntityDescription.insertNewObjectForEntityForName(TaskGroup.entityName, inManagedObjectContext: managedObjectContext) as! TaskGroup

        item.creationDate = NSDate()
        item.title = title

        do {
            try managedObjectContext.save()
        } catch {
            fatalError("Error saving TaskGroup")
        }

        return item
    }

    public class func insertTaskItemWithTitle(title: String, inTaskGroup taskGroup: TaskGroup?, inManagedObjectContext managedObjectContext: NSManagedObjectContext) -> TaskItem {

        let item = NSEntityDescription.insertNewObjectForEntityForName(TaskItem.entityName, inManagedObjectContext: managedObjectContext) as! TaskItem

        item.title = title
        item.creationDate = NSDate()
        item.isComplete = false
        item.taskGroup = taskGroup

        do {
            try managedObjectContext.save()
        } catch {
            fatalError("Error saving TaskGroup")
        }

        return item
    }
}