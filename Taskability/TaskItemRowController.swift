//
//  TaskItemRowController.swift
//  Taskability
//
//  Created by Connor Krupp on 14/04/2016.
//  Copyright © 2016 Connor Krupp. All rights reserved.
//

import WatchKit

class TaskItemRowController: NSObject {

    @IBOutlet weak var titleLabel: WKInterfaceLabel!

    func setText(text: String) {
        titleLabel.setText(text)
    }

}