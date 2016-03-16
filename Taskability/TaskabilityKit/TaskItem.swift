//
//  TaskItem.swift
//  Taskability
//
//  Created by Connor Krupp on 15/03/2016.
//  Copyright © 2016 Connor Krupp. All rights reserved.
//

import Foundation

public struct TaskItem {

    // MARK: Properties

    /// Title and subtitle describing the task
    public var title: String
    public var subtitle: String?

    /// When is this task your main focus?
    public var startDate: NSDate?
    public var endDate: NSDate?

    /// String representation of task location
    public var location: String?

    /// Array of reminder dates for push notifications
    public var reminders = [NSDate]()

    /// Is this item completed?
    public var isComplete = false

    /// Unique Identifier
    private var UUID = NSUUID()

    /**
     Initializes a TaskItem instance with designated title

      - parameter title: Title of this TaskItem
    */

    public init(title: String) {
        self.title = title
    }

    /**
     Initializes a TaskItem instance with designated title and completeness

      - parameter title: Title of this TaskItem
      - parameter isComplete: Whether this item is complete
    */
    
    public init(title: String, isComplete: Bool) {
        self.title = title
        self.isComplete = isComplete
    }

}