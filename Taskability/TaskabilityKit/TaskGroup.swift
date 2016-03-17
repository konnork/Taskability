//
//  TaskGroup.swift
//  Taskability
//
//  Created by Connor Krupp on 17/03/2016.
//  Copyright © 2016 Connor Krupp. All rights reserved.
//

import Foundation

public struct TaskGroup {

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
}
