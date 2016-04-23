//
//  Task.swift
//  Taskability
//
//  Created by Connor Krupp on 21/03/2016.
//  Copyright © 2016 Connor Krupp. All rights reserved.
//

import Foundation

public class Task: Comparable {

    public var title: String
    public var isComplete: Bool
    public var creationDate: NSDate
    public var dueDate: NSDate?

    public init(title: String, isComplete: Bool = false, dueDate: NSDate? = nil) {
        self.title = title
        self.isComplete = isComplete
        self.creationDate = NSDate()
    }
}

// MARK: Equatable

public func ==(x: Task, y: Task) -> Bool {
    return x.dueDate == y.dueDate
}

// MARK: Comparable

/** Comparison between tasks are based on their respective due dates, as well as completeness.
    Comparison is defined as follows:
    if both tasks are complete or incomplete, then the task with the more recent due date is least element.
    if either task does not share completenesss, the incomplete task is least element.
*/
public func <(x: Task, y: Task) -> Bool {
    if (x.isComplete && y.isComplete) || (!x.isComplete && !y.isComplete) {
        if let xDueDate = x.dueDate {
            if let yDueDate = y.dueDate {
                return xDueDate.compare(yDueDate) == .OrderedAscending
            } else {
                return true
            }
        } else {
            return false
        }
    } else if x.isComplete {
        return false
    } else {
        return true
    }
}