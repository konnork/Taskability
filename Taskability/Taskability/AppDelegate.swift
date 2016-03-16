//
//  AppDelegate.swift
//  Taskability
//
//  Created by Connor Krupp on 15/03/2016.
//  Copyright © 2016 Connor Krupp. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        UIGraphicsBeginImageContext(self.window!.frame.size)
        UIImage(named: "WindowBackground")!.drawInRect(self.window!.bounds)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        self.window?.backgroundColor = UIColor(patternImage: image)

        UITabBar.appearance().tintColor = UIColor.whiteColor()

        return true
    }

}

