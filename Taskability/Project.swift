//
//  Project.swift
//  Taskability
//
//  Created by Connor Krupp on 21/03/2016.
//  Copyright © 2016 Connor Krupp. All rights reserved.
//

import Foundation

public class Project: CustomStringConvertible {

    public var creationDate: NSDate
    public var title: String
    public var tasks: [Task]
    public var imageName: String

    public init(title: String, imageName: String = "code") {
        self.title = title
        self.creationDate = NSDate()
        self.tasks = []
        self.imageName = imageName
    }

    public var description: String {
        return "\(title): Task Count: \(tasks.count) Created On: \(creationDate)"
    }

    public func nextTask() -> Task? {
        return tasks.minElement()
    }

    public func append(task: Task) {
        tasks.append(task)
    }

}
