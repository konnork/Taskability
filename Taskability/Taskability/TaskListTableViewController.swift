//
//  TaskListTableViewController.swift
//  Taskability
//
//  Created by Connor Krupp on 15/03/2016.
//  Copyright © 2016 Connor Krupp. All rights reserved.
//

import UIKit
import CoreData
import TaskabilityKit

protocol TaskListTableViewControllerDelegate: class {
    //func didRemoveTaskItem(taskItem: TaskItem, inTaskGroup taskGroup: TaskGroup)
    //func didUpdateTaskItem(taskItem: TaskItem, inTaskGroup taskGroup: TaskGroup)
}

class TaskListTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    // MARK: Types

    struct MainStoryboard {
        struct TableViewCellIdentifiers {
            // Normal TaskListItem Cell
            static let taskListItemCell = "taskListItemCell"
        }
    }

    // MARK: Properties

    weak var delegate: TaskListTableViewControllerDelegate?

    var fetchedResultsController: NSFetchedResultsController!

    var managedObjectContext: NSManagedObjectContext {
        return taskGroup.managedObjectContext!
    }

    var taskGroup: TaskGroup!

    // MARK: View Lifecycle

    override func viewDidLoad() {
        initializeFetchedResultsController()

        self.title = NSLocalizedString(taskGroup.valueForKey("title") as! String, comment: "Task Group Title")
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1.0)
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
        managedObjectContext.deleteObject(fetchedResultsController.objectAtIndexPath(indexPath) as! TaskItem)
        saveContext()
    }

    // MARK: UITableViewDelegate

    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        switch cell {
        case let cell as TaskListItemTableViewCell:
            cell.selectionStyle = .None
            let taskItem = fetchedResultsController.objectAtIndexPath(indexPath) as! TaskItem
            cell.titleLabel.text = taskItem.valueForKey("title") as? String
            cell.isComplete = taskItem.valueForKey("isComplete") as! Bool
        default:
            fatalError("Unknown Cell Type")
        }
    }

    // MARK: IBActions

    @IBAction func checkmarkTapped(sender: Checkmark) {
        let tapLocation = tableView.convertPoint(sender.bounds.origin, fromView: sender)
        if let indexPath = tableView.indexPathForRowAtPoint(tapLocation) {
            let taskItem = fetchedResultsController.objectAtIndexPath(indexPath) as! TaskItem
            taskItem.setValue(!(taskItem.valueForKey("isComplete") as! Bool), forKey: "isComplete")
            saveContext()
        }
    }

    // MARK: NSFetchedResultsController

    func initializeFetchedResultsController() {
        let request = NSFetchRequest(entityName: "TaskItem")
        let managedObjectContext = taskGroup.managedObjectContext!

        request.predicate = NSPredicate(format: "taskGroup == %@", taskGroup)
        request.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]

        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)

        fetchedResultsController.delegate = self

        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
    }

    // MARK: NSFetchedResultsControllerDelegate

    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }

    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
        case .Delete:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
        case .Update:
            tableView.reloadRowsAtIndexPaths([indexPath!], withRowAnimation: .Automatic)
        case .Move:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
            tableView.insertRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
        }
    }

    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }

    // MARK: Core Data Helpers

    func saveContext() {
        do {
            try managedObjectContext.save()
        } catch {
            fatalError("Error saving managedObjectContext \(error)")
        }
    }
}
