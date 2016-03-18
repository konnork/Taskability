//
//  DemoTasks.swift
//  Taskability
//
//  Created by Connor Krupp on 16/03/2016.
//  Copyright © 2016 Connor Krupp. All rights reserved.
//

import Foundation

public struct DemoTasks {

    public static let demoGroups = [
        TaskGroup(title: "Food", tasks: DemoTasks.foodItems),
        TaskGroup(title: "Movies", tasks: DemoTasks.movieItems)
    ]

    public static let foodItems = [
        TaskItem(title: "Apple", isComplete: false),
        TaskItem(title: "Banana", isComplete: true),
        TaskItem(title: "Carrot", isComplete: false),
        TaskItem(title: "Donut", isComplete: false),
        TaskItem(title: "Chips", isComplete: false),
        TaskItem(title: "Salsa", isComplete: false),
        TaskItem(title: "Ice Cream", isComplete: false),
        TaskItem(title: "Elephant Ear", isComplete: true)
    ]

    public static let movieItems = [
        TaskItem(title: "Hangover 2", isComplete: false),
        TaskItem(title: "Interstellar", isComplete: false),
        TaskItem(title: "Deadpool", isComplete: true),
        TaskItem(title: "Avengers 4", isComplete: false)
    ]
}
