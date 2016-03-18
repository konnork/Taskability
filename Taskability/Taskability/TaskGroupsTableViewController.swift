//
//  TaskGroupCollectionViewController.swift
//  Taskability
//
//  Created by Connor Krupp on 17/03/2016.
//  Copyright © 2016 Connor Krupp. All rights reserved.
//

import UIKit
import TaskabilityKit

class TaskGroupsTableViewController: UITableViewController {

    // MARK: Types

    struct MainStoryboard {
        struct CellIdentifiers {
            static let taskGroupHeaderCell = "taskGroupHeaderCell"
            static let taskGroupCell = "taskGroupCell"
        }

        struct SegueIdentifier {
            static let showTaskList = "showTaskList"
        }
    }

    // MARK: Properties

    var taskGroups = [TaskGroup]()


    // MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1.0)
        tableView.tableFooterView = UIView()

        if let taskGroups = loadTaskGroups() {
            self.taskGroups += taskGroups
        } else {
            self.taskGroups = DemoTasks.demoGroups
            saveTaskGroups()
        }

    }

    // MARK: UICollectionViewDataSource

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskGroups.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = MainStoryboard.CellIdentifiers.taskGroupCell
        return tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
    }

    // MARK: UICollectionViewDelegate

    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        switch cell {
        case let cell as TaskGroupTableViewCell:
            cell.titleLabel.text = taskGroups[indexPath.row].title
            cell.itemCountLabel.text = "\(taskGroups[indexPath.row].tasks.count) ITEMS"
        default:
            fatalError("Unknown cell type")
        }
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier! {
        case MainStoryboard.SegueIdentifier.showTaskList:
            let taskListTableViewController = segue.destinationViewController as! TaskListTableViewController
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
            taskListTableViewController.taskGroup = taskGroups[tableView.indexPathForSelectedRow!.row]
        default:
            fatalError("Unknown Segue")
        }
    }

    // MARK: NSCoding

    func saveTaskGroups() {
        let archiveUrl = try! NSFileManager().URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: true).URLByAppendingPathComponent("taskGroups")

        NSKeyedArchiver.archiveRootObject(taskGroups, toFile: archiveUrl.path!)
    }

    func loadTaskGroups() -> [TaskGroup]? {
        let archiveUrl = try! NSFileManager().URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: true).URLByAppendingPathComponent("taskGroups")

        return NSKeyedUnarchiver.unarchiveObjectWithFile(archiveUrl.path!) as? [TaskGroup]
    }

}
