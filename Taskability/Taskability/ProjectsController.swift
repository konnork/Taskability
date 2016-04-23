//
//  ProjectsController.swift
//  Taskability
//
//  Created by Connor Krupp on 22/04/2016.
//  Copyright © 2016 Connor Krupp. All rights reserved.
//

import Foundation

public final class ProjectsController {

    private var projects = [Project]()

    // Must have a public initializer
    public init() {

    }

    public var count: Int {
        return projects.count
    }

    public subscript(idx: Int) -> Project {
        return projects[idx]
    }

    public func append(project: Project) {
        projects.append(project)
    }

    public func removeProjectAtIndex(index: Int) {
        projects.removeAtIndex(index)
    }
}