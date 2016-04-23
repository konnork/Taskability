//
//  TaskItem.swift
//  Taskability
//
//  Created by Connor Krupp on 21/03/2016.
//  Copyright © 2016 Connor Krupp. All rights reserved.
//

import Foundation

public class TaskItem {

    @NSManaged public var title: String!
    @NSManaged public var isComplete: NSNumber!
    @NSManaged public var creationDate: NSDate!
    @NSManaged public var subtitle: String?
    @NSManaged public var startDate: NSDate?
    @NSManaged public var endDate: NSDate?
    @NSManaged public var location: String?

    public static let entityName = "TaskItem"

}
