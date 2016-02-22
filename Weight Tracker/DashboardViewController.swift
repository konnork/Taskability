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
    var weightData = [WeightItem]()

    // MARK: ViewController Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        for mass in 60..<100 {
            weightData.append(WeightItem(mass: Double(mass)))
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weightData.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let weightCell = collectionView.dequeueReusableCellWithReuseIdentifier(MainStoryboard.CollectionViewCellIdentifiers.weightCell, forIndexPath: indexPath)

        weightCell.backgroundColor = UIColor.redColor()

        return weightCell
    }
}

