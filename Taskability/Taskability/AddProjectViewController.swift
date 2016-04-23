//
//  AddProjectViewController.swift
//  Taskability
//
//  Created by Connor Krupp on 18/04/2016.
//  Copyright © 2016 Connor Krupp. All rights reserved.
//

import UIKit

protocol AddProjectViewControllerDelegate: class {
    func didCancelAddingProject()
    func didAddProjectWithTitle(title: String)
}

class AddProjectViewController: UIViewController {

    @IBOutlet weak var projectNameTextField: UITextField!

    weak var delegate: AddProjectViewControllerDelegate?

    @IBAction func cancelAddingProject() {
        delegate?.didCancelAddingProject()
    }

    @IBAction func addProject() {
        delegate?.didAddProjectWithTitle(projectNameTextField.text!)
    }
}
