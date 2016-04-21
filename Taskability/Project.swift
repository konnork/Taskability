//
//  Project.swift
//  Taskability
//
//  Created by Connor Krupp on 21/03/2016.
//  Copyright © 2016 Connor Krupp. All rights reserved.
//

import Foundation
import CoreData

@objc(Project)
public class Project: NSManagedObject {

    @NSManaged public var creationDate: NSDate!
    @NSManaged public var title: String!
    @NSManaged public var tasks: [TaskItem]?

    public static let entityName = "Project"

    public var count: Int {
        return tasks?.count ?? 0
    }

}
