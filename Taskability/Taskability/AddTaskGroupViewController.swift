//
//  AddTaskGroupViewController.swift
//  Taskability
//
//  Created by Connor Krupp on 18/04/2016.
//  Copyright © 2016 Connor Krupp. All rights reserved.
//

import UIKit

protocol AddTaskGroupViewControllerDelegate: class {
    func didCancelAddingTaskGroup()
    func didAddTaskGroupWithName(name: String)
}

class AddTaskGroupViewController: UIViewController {

    @IBOutlet weak var taskGroupNameTextField: UITextField!

    weak var delegate: AddTaskGroupViewControllerDelegate?

    @IBAction func cancelAddingTaskGroup() {
        delegate?.didCancelAddingTaskGroup()
    }

    @IBAction func addTaskGroup() {
        delegate?.didAddTaskGroupWithName(taskGroupNameTextField.text!)
    }
}
