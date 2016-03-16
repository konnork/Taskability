//
//  TaskabilityTabBarController.swift
//  Taskability
//
//  Created by Connor Krupp on 16/03/2016.
//  Copyright © 2016 Connor Krupp. All rights reserved.
//

import UIKit

class TaskabilityTabBarController: UITabBarController {

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        var tabBarFrame = tabBar.frame
        tabBarFrame.size.height = 67
        tabBarFrame.origin.y = view.frame.size.height - 67
        tabBar.frame = tabBarFrame

        if let tabBarItems = tabBar.items {
            let addTaskTabBarImage = UIImage(named: "AddTaskItemTab")?.imageWithRenderingMode(.AlwaysOriginal)
            let centerItemIndex = tabBarItems.count / 2 // Integer division, 5/2 == 2
            tabBarItems[centerItemIndex].image = addTaskTabBarImage
            tabBarItems[centerItemIndex].selectedImage = addTaskTabBarImage
        }
    }

    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        print(tabBar.selectedItem?.tag)
    }

}
