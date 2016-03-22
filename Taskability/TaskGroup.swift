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

    @NSManaged var title: String?
    @NSManaged var tasks: [TaskItem]?

    func count() -> Int {
        return tasks?.count ?? 0
    }

}
