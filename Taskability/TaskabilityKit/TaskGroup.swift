//
//  TaskGroup.swift
//  Taskability
//
//  Created by Connor Krupp on 17/03/2016.
//  Copyright © 2016 Connor Krupp. All rights reserved.
//

import Foundation

public class TaskGroup: NSObject, NSCoding {

    // MARK: Types

    struct PropertyKey {
        static let titleKey = "title"
        static let tasksKey = "tasks"
    }

    // MARK: Properties

    public var tasks = [TaskItem]()

    public var title: String!

    public init(title: String) {
        self.title = title
    }

    public init(title: String, tasks: [TaskItem]) {
        self.title = title
        self.tasks = tasks
    }

    // MARK: NSCoding
    
    public required init(coder aDecoder: NSCoder) {
        title = aDecoder.decodeObjectForKey(PropertyKey.titleKey) as! String
        tasks = aDecoder.decodeObjectForKey(PropertyKey.tasksKey) as! [TaskItem]
    }
    
    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(title, forKey: PropertyKey.titleKey)
        aCoder.encodeObject(tasks, forKey: PropertyKey.tasksKey)
    }

}
