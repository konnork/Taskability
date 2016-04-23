//
//  ProjectsTableViewController.swift
//  Taskability
//
//  Created by Connor Krupp on 16/04/2016.
//  Copyright © 2016 Connor Krupp. All rights reserved.
//

import UIKit
import TaskabilityKit

class ProjectsTableViewController: UITableViewController, AddProjectViewControllerDelegate {

    // MARK: Types

    struct Storyboard {
        static let projectCellIdentifier = "ProjectCell"
    }

    // MARK: Properties

    var projectsController: ProjectsController!

    // MARK: View Controller Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()


    }

    // MARK: Segue Handling

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toAddTaskGroupViewController" {
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
