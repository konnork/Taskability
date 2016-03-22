//
//  TaskGroupCollectionViewController.swift
//  Taskability
//
//  Created by Connor Krupp on 17/03/2016.
//  Copyright © 2016 Connor Krupp. All rights reserved.
//

import UIKit
import CoreData
import TaskabilityKit

class TaskGroupsTableViewController: UITableViewController, TaskListTableViewControllerDelegate {

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

    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var headerSubtitle: UILabel!
    
    // MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1.0)
        tableView.tableFooterView = UIView()

        let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).dataController.managedObjectContext

        let group = NSEntityDescription.insertNewObjectForEntityForName("TaskGroup", inManagedObjectContext: managedObjectContext) as! TaskGroup

        group.setValue("Food", forKey: "title")

        do {
            try managedObjectContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "loadData")

    }

    func loadData() {
        let moc = (UIApplication.sharedApplication().delegate as! AppDelegate).dataController.managedObjectContext
        let groupsFetch = NSFetchRequest(entityName: "TaskGroup")

        do {
            let fetchedGroups = try moc.executeFetchRequest(groupsFetch) as! [TaskGroup]
            for group in fetchedGroups {
                print(group.valueForKey("title"))
            }
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
    }


    // MARK: UICollectionViewDataSource

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = MainStoryboard.CellIdentifiers.taskGroupCell
        return tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
    }

    // MARK: UICollectionViewDelegate

    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        switch cell {
        case let cell as TaskGroupTableViewCell:
            break
        default:
            fatalError("Unknown cell type")
        }
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier! {
        case MainStoryboard.SegueIdentifier.showTaskList:
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        default:
            fatalError("Unknown Segue")
        }
    }

}
