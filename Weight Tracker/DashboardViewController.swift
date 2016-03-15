//
//  ViewController.swift
//  Weight Tracker
//
//  Created by Connor Krupp on 21/02/2016.
//  Copyright © 2016 Connor Krupp. All rights reserved.
//

import UIKit
import WeightKit

class DashboardViewController: UICollectionViewController {

    // MARK: Types

    struct MainStoryboard {
        struct CollectionViewCellIdentifiers {
            static let healthCell = "healthCell"
        }
    }

    // MARK: Properties

    /// Temporarily initialized as array
    ///   will be more complex with iCloud/Healthkit
    var healthController = [HealthElement]()

    // MARK: ViewController Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        for mass in 60...100 {
            healthController.append(HealthElement(mass: Double(mass)))
        }

    }

    // MARK: UICollectionViewDataSource

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return healthController.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCellWithReuseIdentifier(MainStoryboard.CollectionViewCellIdentifiers.healthCell, forIndexPath: indexPath) as! HealthCell
    }


    // MARK: UICollectionViewDelegate

    override func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        switch cell {
        case let healthCell as HealthCell:

            let healthData = healthController[indexPath.row]
            healthCell.label.text = "\(healthData.mass)"
            healthCell.label.font = UIFont.preferredFontForTextStyle(UIFontTextStyleCallout)
            healthCell.label.textColor = UIColor.redColor()

        default:
            fatalError("Invalid cell type in DashboardViewController")
        }
    }
}

