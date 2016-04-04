//
//  TaskabilityTabBarController.swift
//  Taskability
//
//  Created by Connor Krupp on 16/03/2016.
//  Copyright © 2016 Connor Krupp. All rights reserved.
//

import UIKit

class TaskabilityTabBarController: UITabBarController, UITabBarControllerDelegate {

    var dataController: DataController!

    override func viewDidLoad() {
        let navigationController = viewControllers?.first as? UINavigationController
        let taskGroupsViewController = navigationController?.viewControllers.first as? StagingAreaTableViewController
        taskGroupsViewController?.dataController = dataController
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        self.delegate = self
    }

}
