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

    public class func createProjectWithTitle(title: String, inManagedObjectContext managedObjectContext: NSManagedObjectContext) -> Project {

        let item = NSEntityDescription.insertNewObjectForEntityForName(Project.entityName, inManagedObjectContext: managedObjectContext) as! Project

        item.creationDate = NSDate()
        item.title = title

        do {
            try managedObjectContext.save()
        } catch {
            fatalError("Error saving TaskGroup")
        }

        return item
    }

    public class func insertTaskItemWithTitle(title: String, inProject project: Project?, inManagedObjectContext managedObjectContext: NSManagedObjectContext) -> TaskItem {

        let item = NSEntityDescription.insertNewObjectForEntityForName(TaskItem.entityName, inManagedObjectContext: managedObjectContext) as! TaskItem

        item.title = title
        item.creationDate = NSDate()
        item.isComplete = false
        item.project = project

        do {
            try managedObjectContext.save()
        } catch {
            fatalError("Error saving TaskGroup")
        }

        return item
    }
}