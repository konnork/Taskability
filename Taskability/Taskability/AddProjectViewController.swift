//
//  AddProjectViewController.swift
//  Taskability
//
//  Created by Connor Krupp on 18/04/2016.
//  Copyright © 2016 Connor Krupp. All rights reserved.
//

import UIKit
import TaskabilityKit

class AddProjectViewController: UIViewController {

    @IBOutlet weak var projectNameTextField: UITextField!

    var projectsController: ProjectsController!

    @IBAction func cancelAddingProject() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func addProject() {
        if let title = projectNameTextField.text {
            if projectsController.canCreateProjectWithTitle(title) {
                let newProject = Project(title: title)
                projectsController.createProject(newProject)
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }
}
