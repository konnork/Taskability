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
    public var tasks: [TaskItem]

    public init(title: String) {
        self.title = title
        self.creationDate = NSDate()
        self.tasks = []
    }

    public var description: String {
        return "\(title): Task Count: \(tasks.count) Created On: \(creationDate)"
    }

}
