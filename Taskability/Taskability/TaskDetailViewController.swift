//
//  TaskDetailViewController.swift
//  Taskability
//
//  Created by Connor Krupp on 21/04/2016.
//  Copyright © 2016 Connor Krupp. All rights reserved.
//

import UIKit
import TaskabilityKit

class TaskDetailViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var titleTextField: UITextField!

    var taskItem: TaskItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Edit Shit"

        titleTextField.text = taskItem.valueForKey("title") as? String
        titleTextField.delegate = self
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidEndEditing(textField: UITextField) {
        taskItem.setValue(textField.text!, forKey: "title")
    }
    
}
