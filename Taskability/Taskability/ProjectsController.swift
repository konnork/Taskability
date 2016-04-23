//
//  ProjectsController.swift
//  Taskability
//
//  Created by Connor Krupp on 22/04/2016.
//  Copyright © 2016 Connor Krupp. All rights reserved.
//

import Foundation

public final class ProjectsController {

    var projects = [Project]()

    public init() {
        // Test Model

        projects.append(Project(title: "EECS 485"))
        projects.append(Project(title: "Michigan Hackers"))
        projects.append(Project(title: "MHacks"))
        projects.append(Project(title: "EECS 388"))

    }

    public var count: Int {
        return projects.count
    }

    public subscript(idx: Int) -> Project {
        return projects[idx]
    }
}