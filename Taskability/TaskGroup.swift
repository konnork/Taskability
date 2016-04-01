//
//  TaskGroup.swift
//  Taskability
//
//  Created by Connor Krupp on 21/03/2016.
//  Copyright © 2016 Connor Krupp. All rights reserved.
//

import Foundation
import CoreData

@objc(TaskGroup)
public class TaskGroup: NSManagedObject {

    @NSManaged var creationDate: NSDate!
    @NSManaged var title: String!
    @NSManaged var tasks: [TaskItem]?

    public static let entityName = "TaskGroup"

    public var count: Int {
        return tasks?.count ?? 0
    }

    public class func insertTaskGroupWithTitle(title: String, inManagedObjectContext managedObjectContext: NSManagedObjectContext) -> TaskGroup {

        let item = NSEntityDescription.insertNewObjectForEntityForName(self.entityName, inManagedObjectContext: managedObjectContext) as! TaskGroup

        item.creationDate = NSDate()
        item.title = title

        do {
            try managedObjectContext.save()
        } catch {
            fatalError("Error saving TaskGroup")
        }
        return item
    }

}
