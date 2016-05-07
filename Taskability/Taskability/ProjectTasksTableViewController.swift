//
//  ProjectTasksTableViewController.swift
//  Taskability
//
//  Created by Connor Krupp on 5/3/16.
//  Copyright © 2016 Connor Krupp. All rights reserved.
//

import UIKit
import TaskabilityKit

class ProjectTasksTableViewController: UITableViewController {
    
    var project: Project!
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        self.navigationItem.title = project.title
    }
    
    // MARK: UITableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return project.tasks.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ProjectTaskCell") as! ProjectTaskTableViewCell
        
        cell.titleLabel.text = project.tasks[indexPath.row].title
        cell.checkmark.isChecked = project.tasks[indexPath.row].isComplete
        
        return cell
    }
}