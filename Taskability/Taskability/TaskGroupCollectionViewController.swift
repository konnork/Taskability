//
//  TaskGroupCollectionViewController.swift
//  Taskability
//
//  Created by Connor Krupp on 16/04/2016.
//  Copyright © 2016 Connor Krupp. All rights reserved.
//

import UIKit
import CoreData
import TaskabilityKit

private let reuseIdentifier = "taskGroupCell"

class TaskGroupCollectionViewController: UICollectionViewController, NSFetchedResultsControllerDelegate, UITextFieldDelegate, AddTaskGroupViewControllerDelegate {

    // MARK: Properties

    /// Core Data Properties

    var dataController: DataController!
    var fetchedResultsController: NSFetchedResultsController!

    var taskGroups: [TaskGroup] {
        return fetchedResultsController.fetchedObjects as! [TaskGroup]
    }

    var managedObjectContext: NSManagedObjectContext {
        return dataController.managedObjectContext
    }

    // MARK: View Controller Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupFetchedResultsController()

        let flowLayout = self.collectionViewLayout as! UICollectionViewFlowLayout
        let itemSideLength = self.view.bounds.width / 2 - 1
        flowLayout.itemSize = CGSizeMake(itemSideLength, itemSideLength)
        flowLayout.minimumInteritemSpacing = 2.0
        flowLayout.minimumLineSpacing = 2.0
    }

    // MARK: Segue Handling

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toAddTaskGroupViewController" {
            let addTaskGroupViewController = segue.destinationViewController as! AddTaskGroupViewController
            addTaskGroupViewController.delegate = self
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return fetchedResultsController.sections!.count
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sections = fetchedResultsController.sections!
        return sections[section].numberOfObjects
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! TaskGroupCollectionViewCell
    }

    override func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        switch cell {
        case let cell as TaskGroupCollectionViewCell:
            cell.titleLabel.text = taskGroups[indexPath.row].valueForKey("title") as? String
        default:
            break
        }
    }

    // MARK: NSFetchedResultsController Helpers

    func setupFetchedResultsController() {
        let taskGroupRequest = NSFetchRequest(entityName: "TaskGroup")
        taskGroupRequest.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        fetchedResultsController = TaskabilityCoreData.initializeFetchedResultsController(withFetchRequest: taskGroupRequest,
                                                                                          inManagedObjectContext: managedObjectContext)
        fetchedResultsController.delegate = self
    }

    // MARK: NSFetchedResultsControllerDelegate

    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            self.collectionView!.insertItemsAtIndexPaths([newIndexPath!])
        case .Delete:
            collectionView!.deleteItemsAtIndexPaths([indexPath!])
        case .Update:
            collectionView!.reloadItemsAtIndexPaths([indexPath!])
        case .Move:
            collectionView!.deleteItemsAtIndexPaths([indexPath!])
            collectionView!.insertItemsAtIndexPaths([indexPath!])
        }
    }

    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        try! managedObjectContext.save()
    }

    // MARK: UITextFieldDelegate

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        TaskabilityCoreData.insertTaskGroupWithTitle(textField.text!, inManagedObjectContext: managedObjectContext)
        textField.resignFirstResponder()
        return true
    }

    // MARK: AddTaskGroupViewControllerDelegate

    func didCancelAddingTaskGroup() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    func didAddTaskGroupWithName(name: String) {
        TaskabilityCoreData.insertTaskGroupWithTitle(name, inManagedObjectContext: managedObjectContext)
        self.dismissViewControllerAnimated(true, completion: nil)
    }


}
