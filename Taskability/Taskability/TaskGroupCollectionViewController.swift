//
//  TaskGroupCollectionViewController.swift
//  Taskability
//
//  Created by Connor Krupp on 17/03/2016.
//  Copyright © 2016 Connor Krupp. All rights reserved.
//

import UIKit
import TaskabilityKit

class TaskGroupCollectionViewController: UICollectionViewController {

    // MARK: Types

    struct MainStoryboard {
        struct CollectionViewIdentifiers {
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
        collectionView?.backgroundColor = UIColor(red: 245/255, green: 244/255, blue: 245/255, alpha: 1.0)
        taskGroups = DemoTasks.demoGroups
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return taskGroups.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCellWithReuseIdentifier(MainStoryboard.CollectionViewIdentifiers.taskGroupCell, forIndexPath: indexPath)
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = UIColor.grayColor()
    }

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier! {
        case MainStoryboard.SegueIdentifier.showTaskList:
            let taskListTableViewController = segue.destinationViewController as! TaskListTableViewController
            print(collectionView?.indexPathsForSelectedItems()![0].row)
            taskListTableViewController.taskGroup = taskGroups[collectionView!.indexPathsForSelectedItems()![0].row]
        default:
            fatalError("Unknown Segue")
        }
    }

}
