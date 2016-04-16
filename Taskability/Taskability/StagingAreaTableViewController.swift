//
//  StagingAreaTableViewController.swift
//  Taskability
//
//  Created by Connor Krupp on 17/03/2016.
//  Copyright © 2016 Connor Krupp. All rights reserved.
//

import UIKit
import CoreData
import TaskabilityKit

class StagingAreaTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, UITextFieldDelegate, StagedTaskTableViewCellDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    // MARK: Types

    struct MainStoryboard {
        struct CellIdentifiers {
            static let taskCell = "taskCell"
        }
    }


    // MARK: Properties

    @IBOutlet weak var newTaskTextField: UITextField!
    @IBOutlet weak var scrollMenuCollectionView: UICollectionView!
    @IBOutlet weak var scrollMenuCollectionViewLeadingConstraint: NSLayoutConstraint!

    var stagedTaskItems: [TaskItem] {
        return fetchedResultsController.fetchedObjects as! [TaskItem]
    }

    var taskGroups: [TaskGroup] {
        return taskGroupsFetchedResultsController.fetchedObjects as! [TaskGroup]
    }

    var selectedTaskGroup: NSIndexPath?

    /// Core Data Properties

    var dataController: DataController!
    var fetchedResultsController: NSFetchedResultsController!
    var taskGroupsFetchedResultsController: NSFetchedResultsController!

    var managedObjectContext: NSManagedObjectContext {
        return dataController.managedObjectContext
    }

    // MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        initializeFetchedResultsControllers()

        tableView.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1.0)
        tableView.tableFooterView = UIView()

        let flowLayout = scrollMenuCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.estimatedItemSize = CGSizeMake(100, 40)
        scrollMenuCollectionViewLeadingConstraint.constant = self.view.bounds.width

        newTaskTextField.delegate = self
        newTaskTextField.attributedPlaceholder = NSAttributedString(string: newTaskTextField.placeholder!, attributes: [NSForegroundColorAttributeName: UIColor.whiteColor()])
        addNewTaskTextFieldToolbar()
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
        let identifier = MainStoryboard.CellIdentifiers.taskCell
        return tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
    }

    // MARK: UITableViewDelegate

    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        switch cell {
        case let cell as StagedTaskTableViewCell:
            cell.selectionStyle = .None
            let taskItem = fetchedResultsController.objectAtIndexPath(indexPath) as! TaskItem
            cell.titleLabel.text = taskItem.valueForKey("title") as? String

            if let taskGroup = taskItem.valueForKey("taskGroup") as? TaskGroup {
                cell.groupLabel.text = taskGroup.valueForKey("title") as? String
            } else {
                cell.groupLabel.text = "Ungrouped"
            }

            cell.isComplete = taskItem.valueForKey("isComplete") as! Bool
            cell.delegate = self
        default:
            fatalError("Unknown cell type")
        }
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
           managedObjectContext.deleteObject(fetchedResultsController.objectAtIndexPath(indexPath) as! TaskItem)
        }
    }

    // MARK: FetchedResultsController

    func initializeFetchedResultsControllers() {
        let request = NSFetchRequest(entityName: "TaskItem")
        let taskGroupRequest = NSFetchRequest(entityName: "TaskGroup")

        request.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        taskGroupRequest.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]

        fetchedResultsController = NSFetchedResultsController(fetchRequest: request,
                                                              managedObjectContext: managedObjectContext,
                                                              sectionNameKeyPath: nil, cacheName: nil)

        taskGroupsFetchedResultsController = NSFetchedResultsController(fetchRequest: taskGroupRequest,
                                                                        managedObjectContext: managedObjectContext,
                                                                        sectionNameKeyPath: nil, cacheName: nil)

        fetchedResultsController.delegate = self
        taskGroupsFetchedResultsController.delegate = self

        do {
            try fetchedResultsController.performFetch()
            try taskGroupsFetchedResultsController.performFetch()
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
        try! managedObjectContext.save()
        tableView.endUpdates()
    }

    // MARK: StagedTaskTableViewCellDelegate

    func checkmarkTapped(onCell cell: StagedTaskTableViewCell) {
        let indexPath = tableView.indexPathForCell(cell)!
        let taskItem = fetchedResultsController.objectAtIndexPath(indexPath) as! TaskItem
        let completeKey = "isComplete"
        let currentCompleteness = taskItem.valueForKey(completeKey) as! Bool
        taskItem.setValue(!currentCompleteness, forKey: completeKey)
    }

    // MARK: UICollectionViewDataSource

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return taskGroups.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("taskGroupCell", forIndexPath: indexPath) as! ScrollMenuCollectionViewCell
        cell.titleLabel.text = taskGroups[indexPath.row].valueForKey("title") as? String

        return cell
    }

    // MARK: UICollectionViewDelegate

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .CenteredHorizontally, animated: true)
        if let oldIndexPath = selectedTaskGroup {
            let cell = collectionView.cellForItemAtIndexPath(oldIndexPath) as! ScrollMenuCollectionViewCell
            cell.backgroundColor = UIColor.whiteColor()
            cell.titleLabel.textColor = UIColor.darkGrayColor()
            if indexPath == oldIndexPath {
                selectedTaskGroup = nil
                return
            }
        }

        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! ScrollMenuCollectionViewCell
        cell.backgroundColor = UIColor.darkGrayColor()
        cell.titleLabel.textColor = UIColor.whiteColor()

        selectedTaskGroup = indexPath
    }


    // MARK: UITextFieldDelegate

    func textFieldDidBeginEditing(textField: UITextField) {
        resizeTableHeaderView(true)
    }

    func textFieldDidEndEditing(textField: UITextField) {
        resizeTableHeaderView(false)
    }

    func resizeTableHeaderView(shouldExpand: Bool) {
        if taskGroups.isEmpty {
            return
        }

        let animationDuration = 0.3
        let sizeAdjustment: CGFloat = 40

        let frame = self.tableView.tableHeaderView!.frame
        let newFrame = CGRectMake(frame.origin.x, frame.origin.y, frame.width,
                                  shouldExpand ? frame.height + sizeAdjustment : frame.height - sizeAdjustment)

        func resizeHeader() {
            self.tableView.tableHeaderView?.frame = newFrame
            self.tableView.tableHeaderView = self.tableView.tableHeaderView
            self.view.layoutIfNeeded()
        }

        if shouldExpand {
            UIView.animateWithDuration(animationDuration, animations: {
                resizeHeader()
                }, completion: { _ in
                    self.scrollMenuCollectionViewLeadingConstraint.constant = 0
                    UIView.animateWithDuration(animationDuration, animations: {
                        self.view.layoutIfNeeded()
                    })
            })
        } else {
            self.scrollMenuCollectionViewLeadingConstraint.constant = self.view.bounds.width

            UIView.animateWithDuration(animationDuration, animations: {
                self.view.layoutIfNeeded()
            }, completion: { _ in
                UIView.animateWithDuration(animationDuration, animations: {
                    resizeHeader()
                })
            })
        }

    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        createTaskItem()
        return true
    }

    // MARK: NewTaskTextField Toolbar Handler

    func addNewTaskTextFieldToolbar() {
        let toolBar = UIToolbar()
        toolBar.barStyle = .Black

        let cancelButton = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(StagingAreaTableViewController.cancelAddingTasks))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(StagingAreaTableViewController.doneAddingTasks))

        toolBar.tintColor = UIColor.whiteColor()
        toolBar.setItems([cancelButton, flexibleSpace, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        toolBar.sizeToFit()

        newTaskTextField.inputAccessoryView = toolBar
    }

    func cancelAddingTasks() {
        newTaskTextField.text = ""
        newTaskTextField.resignFirstResponder()
    }

    func doneAddingTasks() {
        createTaskItem()
        newTaskTextField.resignFirstResponder()
    }

    func createTaskItem() {
        let title = newTaskTextField.text!
        if !title.isEmpty {
            var taskGroup: TaskGroup? = nil
            if let selectedTaskGroupIndexPath = selectedTaskGroup {
                taskGroup = taskGroups[selectedTaskGroupIndexPath.row]
            }

            TaskItem.insertTaskItemWithTitle(title, inTaskGroup: taskGroup, inManagedObjectContext: managedObjectContext)
            newTaskTextField.text = ""
            selectedTaskGroup = nil
        }
    }

}
