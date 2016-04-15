//
//  TasksTableInterfaceController.swift
//  Taskability
//
//  Created by Connor Krupp on 14/04/2016.
//  Copyright © 2016 Connor Krupp. All rights reserved.
//

import WatchKit

class TasksTableInterfaceController: WKInterfaceController {

    @IBOutlet weak var interfaceTable: WKInterfaceTable!

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()

        let data = ["Connor Krupp", "Kruppcon", "C4CS"]

        interfaceTable.setNumberOfRows(data.count, withRowType: "TaskItemControllerItemRowType")
        for i in 0..<data.count {
            let taskItemRowController = interfaceTable.rowControllerAtIndex(i) as! TaskItemRowController
            taskItemRowController.setText(data[i])
        }
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
