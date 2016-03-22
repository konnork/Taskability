//
//  TaskListTableViewController.swift
//  Taskability
//
//  Created by Connor Krupp on 15/03/2016.
//  Copyright © 2016 Connor Krupp. All rights reserved.
//

import UIKit
import TaskabilityKit

protocol TaskListTableViewControllerDelegate: class {
    //func didRemoveTaskItem(taskItem: TaskItem, inTaskGroup taskGroup: TaskGroup)
    //func didUpdateTaskItem(taskItem: TaskItem, inTaskGroup taskGroup: TaskGroup)
}

class TaskListTableViewController: UITableViewController {

    // MARK: Types

    struct MainStoryboard {
        struct TableViewCellIdentifiers {
            // Normal TaskListItem Cell
            static let taskListItemCell = "taskListItemCell"
        }
    }

    // MARK: Properties

    weak var delegate: TaskListTableViewControllerDelegate?

    // MARK: View Lifecycle

    override func viewDidLoad() {
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1.0)
    }

    // MARK: UITableViewDataSource

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCellWithIdentifier(MainStoryboard.TableViewCellIdentifiers.taskListItemCell, forIndexPath: indexPath)
    }

    /// Temporary solution
    /// Will replace by customizing TaskListItemTableViewCell to implemenet PanGestureRecognizer and an animated CAShapeLayer underneath
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let deleteButton = UITableViewRowAction(style: .Default, title: "Delete", handler: { _, indexPath in
            self.deleteTaskItemAtIndexPath(indexPath)
        })
        deleteButton.backgroundColor = UIColor(red: 80/255, green: 210/255, blue: 194/255, alpha: 1.0)

        return [deleteButton]
    }

    func deleteTaskItemAtIndexPath(indexPath: NSIndexPath) {
    }

    // MARK: UITableViewDelegate

    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        switch cell {
        case let cell as TaskListItemTableViewCell:
            cell.selectionStyle = .None
        default:
            fatalError("Unknown Cell Type")
        }
    }

    // MARK: IBActions

    @IBAction func checkmarkTapped(sender: Checkmark) {
        let tapLocation = tableView.convertPoint(sender.bounds.origin, fromView: sender)
        if let indexPath = tableView.indexPathForRowAtPoint(tapLocation) {
        }
    }

}
