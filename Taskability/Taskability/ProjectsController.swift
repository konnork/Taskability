//
//  ProjectsController.swift
//  Taskability
//
//  Created by Connor Krupp on 22/04/2016.
//  Copyright © 2016 Connor Krupp. All rights reserved.
//

import Foundation

public enum ProjectsControllerChangeType : UInt {
    case Insert
    case Delete
    case Move
    case Update
}

public protocol ProjectsControllerDelegate : class {

    func projectsController(projectsController: ProjectsController, didChangeProject project: Project, atIndex index: Int?, forChangeType changeType: ProjectsControllerChangeType, newIndex: Int?)

    func projectsControllerWillChangeContent(projectsController: ProjectsController)

    func projectsControllerDidFinishChangingContent(projectsController: ProjectsController)

}

public extension ProjectsControllerDelegate {
    
    func projectsControllerWillChangeContent(projectsController: ProjectsController) { }

    func projectsControllerDidFinishChangingContent(projectsController: ProjectsController) { }
}

public final class ProjectsController {

    private var projects = [Project]()

    public weak var delegate: ProjectsControllerDelegate?

    // Must have a public initializer
    public init() { }

    public var count: Int {
        return projects.count
    }

    public var isEmpty: Bool {
        return projects.isEmpty
    }

    public subscript(idx: Int) -> Project {
        return projects[idx]
    }

    public func createProject(project: Project) {
        delegate?.projectsControllerWillChangeContent(self)

        projects.append(project)
        delegate?.projectsController(self, didChangeProject: project, atIndex: nil, forChangeType: .Insert, newIndex: projects.count - 1)

        delegate?.projectsControllerDidFinishChangingContent(self)
    }

    public func removeProjectAtIndex(index: Int) {
        projects.removeAtIndex(index)
    }

    public func canCreateProjectWithTitle(title: String) -> Bool {
        if title.isEmpty {
            return false
        }

        for project in projects {
            if project.title == title {
                return false
            }
        }
        return true
    }
}