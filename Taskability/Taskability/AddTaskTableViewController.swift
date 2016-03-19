//
//  AddTaskTableViewController.swift
//  Taskability
//
//  Created by Connor Krupp on 18/03/2016.
//  Copyright © 2016 Connor Krupp. All rights reserved.
//

import UIKit
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
        saveTask(TaskItem(title: titleTextField.text!))
        dismissViewControllerAnimated(true, completion: nil)
    }

    // Just bootstrapping this
    func saveTask(task: TaskItem) {
        var taskGroups = NSKeyedUnarchiver.unarchiveObjectWithFile(TaskGroup.ArchiveUrl.path!) as? [TaskGroup]
        if let groups = taskGroups {
            if let index = groups.indexOf({ $0.title == groupTextField.text!}) {
                taskGroups![index].tasks.append(task)
            } else {
                taskGroups!.append(TaskGroup(title: groupTextField.text!, tasks: [task]))
            }
        } else {
            taskGroups = [TaskGroup(title: groupTextField.text!, tasks: [task])]
        }

        NSKeyedArchiver.archiveRootObject(taskGroups!, toFile: TaskGroup.ArchiveUrl.path!)

    }
}
