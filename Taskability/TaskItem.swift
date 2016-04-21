//
//  TaskItem.swift
//  Taskability
//
//  Created by Connor Krupp on 21/03/2016.
//  Copyright © 2016 Connor Krupp. All rights reserved.
//

import Foundation
import CoreData

@objc(TaskItem)
public class TaskItem: NSManagedObject {

    @NSManaged public var title: String!
    @NSManaged public var isComplete: NSNumber!
    @NSManaged public var creationDate: NSDate!
    @NSManaged public var subtitle: String?
    @NSManaged public var startDate: NSDate?
    @NSManaged public var endDate: NSDate?
    @NSManaged public var location: String?
    @NSManaged public var project: Project?

    public static let entityName = "TaskItem"

}
