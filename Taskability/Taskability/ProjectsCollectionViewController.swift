//
//  TaskGroupCollectionViewController.swift
//  Taskability
//
//  Created by Connor Krupp on 16/04/2016.
//  Copyright © 2016 Connor Krupp. All rights reserved.
//

import UIKit
import CloudKit
import TaskabilityKit

class TaskGroupCollectionViewController: UICollectionViewController, UITextFieldDelegate, AddTaskGroupViewControllerDelegate {

    // MARK: Properties

    struct Storyboard {
        static let projectCellIdentifier = "ProjectCell"
    }

    var projects = [CKRecord]() {
        didSet {
            collectionView?.performBatchUpdates({self.collectionView?.reloadSections(NSIndexSet(index: 0))}, completion: nil)
        }
    }

    var privateDatabase: CKDatabase {
        return CKContainer.defaultContainer().privateCloudDatabase
    }



    // MARK: View Controller Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        let flowLayout = self.collectionViewLayout as! UICollectionViewFlowLayout
        let itemSideLength = self.view.bounds.width / 3 - 1
        flowLayout.itemSize = CGSizeMake(itemSideLength, itemSideLength)
        flowLayout.minimumInteritemSpacing = 1.5
        flowLayout.minimumLineSpacing = 1.5

        fetchProjects()
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
        return 1
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return projects.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCellWithReuseIdentifier(Storyboard.projectCellIdentifier, forIndexPath: indexPath) as! ProjectCollectionViewCell
    }

    override func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        switch cell {
        case let cell as ProjectCollectionViewCell:
            cell.titleLabel.text = projects[indexPath.row].objectForKey("title") as? String
        default:
            break
        }
    }

    // MARK: UITextFieldDelegate

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    // MARK: AddTaskGroupViewControllerDelegate

    func didCancelAddingTaskGroup() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    func didAddTaskGroupWithTitle(title: String) {
        let project = CKRecord(recordType: "Projects")
        project.setObject(title, forKey: "title")

        privateDatabase.saveRecord(project) { (record, error) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.processResponseForUpdate(record, error: error)
            })
        }

        self.dismissViewControllerAnimated(true, completion: nil)
    }

    func fetchProjects() {
        let query = CKQuery(recordType: "Projects", predicate: NSPredicate(format: "TRUEPREDICATE"))
        query.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]

        privateDatabase.performQuery(query, inZoneWithID: nil) { (records, error) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.processResponseForQuery(records, error: error)
            })
        }
    }

    func processResponseForQuery(records: [CKRecord]?, error: NSError?) {
        if let error = error {
            print(error)
        } else if let records = records {
            projects = records
        }
    }

    func processResponseForUpdate(record: CKRecord?, error: NSError?) {
        if let error = error {
            print(error)
        } else if let record = record {
            projects.insert(record, atIndex: 0)
        }
    }


}
