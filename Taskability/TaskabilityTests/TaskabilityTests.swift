//
//  TaskabilityTests.swift
//  TaskabilityTests
//
//  Created by Connor Krupp on 23/04/2016.
//  Copyright © 2016 Connor Krupp. All rights reserved.
//

import XCTest
@testable import TaskabilityKit

class TaskabilityTests: XCTestCase {

    var projectsController: ProjectsController!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.

        projectsController = ProjectsController()

        projectsController.append(Project(title: "Test"))
        projectsController.append(Project(title: "Test 1"))
        projectsController.append(Project(title: "Test 2"))
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testInitializer() {
        projectsController = ProjectsController()

        XCTAssert(projectsController.count == 0)
    }

    func testAppend() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssert(projectsController.count == 3)

        projectsController.removeProjectAtIndex(2)

        XCTAssert(projectsController.count == 2)
        
    }

    func testMinElement() {
        let task1 = Task(title: "First Task", isComplete: false, dueDate: NSDate(timeInterval: 100, sinceDate: NSDate()))
        let task2 = Task(title: "Second Task", isComplete: true, dueDate: NSDate(timeInterval: 1000, sinceDate: NSDate()))
        let task3 = Task(title: "First Task", isComplete: false, dueDate: NSDate(timeInterval: 10000, sinceDate: NSDate()))

        projectsController[0].append(task1)
        projectsController[0].append(task2)
        projectsController[0].append(task3)

        XCTAssert(projectsController[0].tasks.minElement() == task1) // not complete and due most recently
        XCTAssert(projectsController[0].tasks.maxElement() == task2) // complete, so last
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
