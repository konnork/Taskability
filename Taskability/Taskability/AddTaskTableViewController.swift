//
//  AddTaskTableViewController.swift
//  Taskability
//
//  Created by Connor Krupp on 18/03/2016.
//  Copyright © 2016 Connor Krupp. All rights reserved.
//

import UIKit
import CoreData
import TaskabilityKit

class AddTaskTableViewController: UITableViewController {

    // MARK: Properties

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var subtitleTextField: UITextField!
    @IBOutlet weak var groupTextField: UITextField!

    /// Core Data Properties

    var dataController: DataController!

    var managedObjectContext: NSManagedObjectContext {
        return dataController.managedObjectContext
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelAction(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func doneAction(sender: UIBarButtonItem) {

        let taskGroup: TaskGroup
        if let group = retrieveGroup() {
            taskGroup = group
        } else {
            taskGroup = TaskGroup.insertTaskGroupWithTitle(groupTextField.text!, inManagedObjectContext: managedObjectContext)
        }

        TaskItem.insertTaskItemWithTitle(titleTextField.text!, inTaskGroup: taskGroup, inManagedObjectContext: managedObjectContext)
        dismissViewControllerAnimated(true, completion: nil)
    }

    func retrieveGroup() -> TaskGroup? {
        let taskGroupsFetchRequest = NSFetchRequest(entityName: "TaskGroup")
        taskGroupsFetchRequest.fetchLimit = 1
        taskGroupsFetchRequest.predicate = NSPredicate(format: "title == %@", groupTextField.text!)
        do {
            let taskGroups = try managedObjectContext.executeFetchRequest(taskGroupsFetchRequest) as! [TaskGroup]
            return taskGroups.first
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
    }

}
