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

class TaskGroupsTableViewController: UITableViewController, TaskListTableViewControllerDelegate, NSFetchedResultsControllerDelegate {

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

    /// Core Data Properties

    var dataController: DataController!
    var fetchedResultsController: NSFetchedResultsController!

    var managedObjectContext: NSManagedObjectContext {
        return dataController.managedObjectContext
    }

    var taskGroups = [TaskGroup]()

    // MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        initializeFetchedResultsController()

        tableView.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1.0)
        tableView.tableFooterView = UIView()
    }

    // MARK: UITableViewDataSource

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return fetchedResultsController.sections!.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sections = fetchedResultsController.sections!
        return sections[section].numberOfObjects
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = MainStoryboard.CellIdentifiers.taskGroupCell
        return tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
    }

    // MARK: UITableViewDelegate

    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        switch cell {
        case let cell as TaskGroupTableViewCell:
            let taskGroup = fetchedResultsController.objectAtIndexPath(indexPath) as! TaskGroup
            cell.titleLabel.text = taskGroup.valueForKey("title") as? String
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

    // MARK: FetchedResultsController

    func initializeFetchedResultsController() {
        let request = NSFetchRequest(entityName: "TaskGroup")
        let managedObjectContext = self.dataController.managedObjectContext
        request.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]

        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: "rootCache")

        fetchedResultsController.delegate = self

        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
    }
}
