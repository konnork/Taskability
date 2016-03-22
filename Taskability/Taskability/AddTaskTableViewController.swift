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

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var subtitleTextField: UITextField!
    @IBOutlet weak var groupTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func cancelAction(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func doneAction(sender: UIBarButtonItem) {
        let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).dataController.managedObjectContext

        let task = NSEntityDescription.insertNewObjectForEntityForName("TaskItem", inManagedObjectContext: managedObjectContext) as! TaskItem
        task.setValue("Task", forKey: "title")
        task.setValue(retrieveGroup(), forKey: "taskGroup")

        do {
            try managedObjectContext.save()
            print("saved")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }

        dismissViewControllerAnimated(true, completion: nil)
    }

    func retrieveGroup() -> TaskGroup {
        let moc = (UIApplication.sharedApplication().delegate as! AppDelegate).dataController.managedObjectContext
        let taskGroups = NSFetchRequest(entityName: "TaskGroup")
        taskGroups.predicate = NSPredicate(format: "title == %@", "Food")
        do {
            let taskGroups = try moc.executeFetchRequest(taskGroups) as! [TaskGroup]
            return taskGroups.first!
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
    }

}
