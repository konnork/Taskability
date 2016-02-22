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
            static let weightCell = "weightCell"
        }
    }

    // MARK: Properties

    /// Temporarily initialized as array
    ///   will be more complex with iCloud/Healthkit
    var weightController = [WeightItem]()

    // MARK: ViewController Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        for mass in 60...100 {
            weightController.append(WeightItem(mass: Double(mass)))
        }

    }

    // MARK: UICollectionViewDataSource

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weightController.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCellWithReuseIdentifier(MainStoryboard.CollectionViewCellIdentifiers.weightCell, forIndexPath: indexPath) as! WeightCell
    }


    // MARK: UICollectionViewDelegate

    override func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        switch cell {
        case let weightCell as WeightCell:

            let weightData = weightController[indexPath.row]
            weightCell.label.text = "\(weightData.mass)"
            weightCell.label.font = UIFont.preferredFontForTextStyle(UIFontTextStyleCallout)
            weightCell.label.textColor = UIColor.redColor()

        default:
            fatalError("Invalid cell type in DashboardViewController")
        }
    }
}

