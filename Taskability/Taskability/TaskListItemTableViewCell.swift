//
//  TaskListItemTableViewCell.swift
//  Taskability
//
//  Created by Connor Krupp on 16/03/2016.
//  Copyright © 2016 Connor Krupp. All rights reserved.
//

import UIKit

class TaskListItemTableViewCell: UITableViewCell {

    // MARK: Properties

    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var checkmark: UIButton!

    var isComplete = false {
        didSet {
            checkmark.setImage(UIImage(named: isComplete ? "TaskListItemCheckmark" : "TaskListItemEmptyCheckmark"), forState: .Normal)
        }
    }
}
