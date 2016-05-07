//
//  ProjectsTableViewController.swift
//  Taskability
//
//  Created by Connor Krupp on 16/04/2016.
//  Copyright © 2016 Connor Krupp. All rights reserved.
//

import UIKit
import TaskabilityKit

class ProjectsTableViewController: UITableViewController, ProjectsControllerDelegate, SegueHandlerType {

    // MARK: Types

    struct Storyboard {
        static let projectCellIdentifier = "ProjectCell"
    }

    enum SegueIdentifier: String {
        case ShowAddProject
        case ShowProjectTasks
    }

    // MARK: Properties

    var projectsController: ProjectsController! {
        didSet { projectsController.delegate = self }
    }

    // MARK: View Controller Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Test Data
        let project = Project(title: "Michigan Hackers", imageName: "mhackers")
        project.tasks.append(Task(title: "Contact Google"))
        project.tasks.append(Task(title: "Email Katie from Microsoft", isComplete: true, dueDate: NSDate(timeIntervalSinceNow: 10000)))
        project.tasks.append(Task(title: "Get Sweatshirts", isComplete: false, dueDate: NSDate(timeIntervalSinceNow: 8000)))
        project.tasks.append(Task(title: "Exec Meeting"))
        
        projectsController.createProject(Project(title: "EECS 485", imageName: "code"))
        projectsController.createProject(project)
        projectsController.createProject(Project(title: "MHacks", imageName: "mhacks"))
        projectsController.createProject(Project(title: "EECS 388", imageName: "code"))

    }

    // MARK: Segue Handling

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        switch segueIdentifierForSegue(segue) {
        case .ShowAddProject:
            let addTaskGroupViewController = segue.destinationViewController as! AddProjectViewController
            addTaskGroupViewController.projectsController = projectsController
        case .ShowProjectTasks:
            let projectTasksViewController = segue.destinationViewController as! ProjectTasksTableViewController
            projectTasksViewController.project = projectsController[tableView.indexPathForSelectedRow!.row]
        }
    }

    // MARK: UITableViewDataSource

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if projectsController.isEmpty {
            displayEmptyTableMessage()
        } else {
            self.tableView.backgroundView = nil
        }
        return projectsController.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.projectCellIdentifier) as! ProjectTableViewCell

        cell.titleLabel.text = projectsController[indexPath.row].title
        cell.projectImageView.image = UIImage(named: projectsController[indexPath.row].imageName)

        if let nextTask = projectsController[indexPath.row].nextTask() {
            cell.nextTaskLabel.text = "\(nextTask.title) due on \(formatDate(nextTask.dueDate!))"
        } else {
            cell.nextTaskLabel.text = "No Tasks Due"
        }

        return cell
    }

    // MARK: ProjectsControllerDelegate

    func projectsControllerWillChangeContent(projectsController: ProjectsController) {
        tableView.beginUpdates()
    }

    func projectsController(projectsController: ProjectsController, didChangeProject project: Project, atIndex index: Int?, forChangeType changeType: ProjectsControllerChangeType, newIndex: Int?) {
        switch changeType {
        case .Insert:
            if projectsController.isEmpty {
                tableView.insertSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
            }
            let indexPath = NSIndexPath(forRow: newIndex!, inSection: 0)
            tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        case .Delete:
            let indexPath = NSIndexPath(forRow: index!, inSection: 0)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            if projectsController.isEmpty {
                tableView.deleteSections(NSIndexSet(index: 0) , withRowAnimation: .Automatic)
            }
        case .Move:
            let oldIndexPath = NSIndexPath(forRow: index!, inSection: 0)
            let newIndexPath = NSIndexPath(forRow: newIndex!, inSection: 0)
            tableView.moveRowAtIndexPath(oldIndexPath, toIndexPath: newIndexPath)
        case .Update:
            let indexPath = NSIndexPath(forRow: index!, inSection: 0)
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }

    func projectsControllerDidFinishChangingContent(projectsController: ProjectsController) {
        tableView.endUpdates()
    }
    
    // MARK: Helpers
    
    func displayEmptyTableMessage() {
        let label = UILabel(frame: CGRect.zero)
        label.text = "You're a wizard Harry"
        label.font = UIFont.systemFontOfSize(20)
        label.numberOfLines = 0
        label.textAlignment = .Center
        label.textColor = UIColor.grayColor()
        label.sizeToFit()
        
        self.tableView.backgroundView = label
    }
    
    func formatDate(date: NSDate) -> String {
        return NSDateFormatter.localizedStringFromDate(date, dateStyle: .MediumStyle, timeStyle: .ShortStyle)
    }
}
