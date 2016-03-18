//
//  TaskItem.swift
//  Taskability
//
//  Created by Connor Krupp on 15/03/2016.
//  Copyright © 2016 Connor Krupp. All rights reserved.
//

import Foundation

public class TaskItem: NSObject, NSCoding {

    // MARK: Properties

    /// Title and subtitle describing the task
    public var title: String

    /// Is this item completed?
    public var isComplete = false

    struct PropertyKey {
        static let titleKey = "title"
        static let isCompleteKey = "isComplete"
    }

    /**
     Initializes a TaskItem instance with designated title

      - parameter title: Title of this TaskItem
    */

    public convenience init(title: String) {
        self.init(title: title, isComplete: false)
    }

    /**
     Initializes a TaskItem instance with designated title and completeness

      - parameter title: Title of this TaskItem
      - parameter isComplete: Whether this item is complete
    */
    
    public init(title: String, isComplete: Bool) {
        self.title = title
        self.isComplete = isComplete

        super.init()
    }


    // MARK: NSCoding

    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(title, forKey: PropertyKey.titleKey)
        aCoder.encodeBool(isComplete, forKey: PropertyKey.isCompleteKey)
    }

    required convenience public init?(coder aDecoder: NSCoder) {
        let title = aDecoder.decodeObjectForKey(PropertyKey.titleKey) as! String
        let isComplete = aDecoder.decodeBoolForKey(PropertyKey.isCompleteKey)

        self.init(title: title, isComplete: isComplete)
    }

}