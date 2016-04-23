//
//  AppDelegate.swift
//  Taskability
//
//  Created by Connor Krupp on 15/03/2016.
//  Copyright © 2016 Connor Krupp. All rights reserved.
//

import UIKit
import TaskabilityKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        UITabBar.appearance().tintColor = UIColor.whiteColor()

        let tabBarController = window?.rootViewController as! UITabBarController
        let navigationController = tabBarController.viewControllers?.first as! UINavigationController
        let projectsCollectionViewController = navigationController.viewControllers.first as! ProjectsTableViewController
        projectsCollectionViewController.projectsController = ProjectsController()
        
        return true
    }

}

