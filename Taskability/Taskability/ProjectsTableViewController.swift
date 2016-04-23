//
//  ProjectsTableViewController.swift
//  Taskability
//
//  Created by Connor Krupp on 16/04/2016.
//  Copyright © 2016 Connor Krupp. All rights reserved.
//

import UIKit
import TaskabilityKit

class ProjectsTableViewController: UITableViewController, AddProjectViewControllerDelegate, SegueHandlerType {

    // MARK: Types

    struct Storyboard {
        static let projectCellIdentifier = "ProjectCell"
    }

    enum SegueIdentifier: String {
        case ShowAddProject
    }

    // MARK: Properties

    var projectsController: ProjectsController!

    // MARK: View Controller Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        projectsController.append(Project(title: "EECS 485", imageName: "code"))
        projectsController.append(Project(title: "Michigan Hackers", imageName: "mhackers"))
        projectsController.append(Project(title: "MHacks", imageName: "mhacks"))
        projectsController.append(Project(title: "EECS 388", imageName: "code"))
    }

    // MARK: Segue Handling

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        switch segueIdentifierForSegue(segue) {
        case .ShowAddProject:
            let addTaskGroupViewController = segue.destinationViewController as! AddProjectViewController
            addTaskGroupViewController.delegate = self
        }
    }

    // MARK: UITableViewDataSource

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projectsController.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.projectCellIdentifier) as! ProjectTableViewCell

        cell.titleLabel.text = projectsController[indexPath.row].title
        cell.projectImageView.image = UIImage(named: projectsController[indexPath.row].imageName)

        if let nextTask = projectsController[indexPath.row].nextTask() {
            cell.nextTaskLabel.text = "\(nextTask.title) due in \(nextTask.dueDate?.timeIntervalSinceNow)"
        } else {
            cell.nextTaskLabel.text = "No Tasks Due"
        }

        return cell
    }

    // MARK: AddProjectViewControllerDelegate

    func didCancelAddingProject() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    func didAddProjectWithTitle(title: String) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
