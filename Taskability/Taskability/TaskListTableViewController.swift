//
//  TaskListTableViewController.swift
//  Taskability
//
//  Created by Connor Krupp on 15/03/2016.
//  Copyright © 2016 Connor Krupp. All rights reserved.
//

import UIKit
import TaskabilityKit

class TaskListTableViewController: UITableViewController {

    // MARK: Types

    struct MainStoryboard {
        struct TableViewCellIdentifiers {
            // Normal TaskListItem Cell
            static let taskListItemCell = "taskListItemCell"
        }
    }

    // MARK: Properties

    var taskItems = [TaskItem]()

    // MARK: View Controller Lifecycle

    override func viewDidLoad() {
        taskItems = DemoTasks.foodItems
    }

    // MARK: UITableViewDataSource

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskItems.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCellWithIdentifier(MainStoryboard.TableViewCellIdentifiers.taskListItemCell, forIndexPath: indexPath)
    }

    /// Temporary solution
    /// Will replace by customizing TaskListItemTableViewCell to implemenet PanGestureRecognizer and an animated CAShapeLayer underneath
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let deleteButton = UITableViewRowAction(style: .Default, title: "Delete", handler: { _, indexPath in
            self.taskItems.removeAtIndex(indexPath.row)
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        })
        deleteButton.backgroundColor = UIColor(red: 80/255, green: 210/255, blue: 194/255, alpha: 1.0)

        return [deleteButton]
    }

    // MARK: UITableViewDelegate

    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        switch cell {
        case let cell as TaskListItemTableViewCell:
            cell.selectionStyle = .None
            cell.isComplete = taskItems[indexPath.row].isComplete
            cell.titleLabel.text = taskItems[indexPath.row].title
        default:
            fatalError("Unknown Cell Type")
        }
    }

    // MARK: IBActions

    @IBAction func checkmarkTapped(sender: Checkmark) {
        let tapLocation = tableView.convertPoint(sender.bounds.origin, fromView: sender)
        if let indexPath = tableView.indexPathForRowAtPoint(tapLocation) {
            taskItems[indexPath.row].isComplete = !taskItems[indexPath.row].isComplete
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
}
