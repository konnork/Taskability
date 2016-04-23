//
//  SegueHandlerType.swift
//  Taskability
//
//  Created by Connor Krupp on 23/04/2016.
//  Copyright © 2016 Connor Krupp. All rights reserved.
//

// SegueHandlerType Protocol inspired from WWDC 2015 Swift in Practice Session 411
// https://developer.apple.com/videos/play/wwdc2015/411/

import UIKit

public protocol SegueHandlerType {
    associatedtype SegueIdentifier: RawRepresentable
}

extension SegueHandlerType where Self: UIViewController, SegueIdentifier.RawValue == String {

    public func performSegueWithIdentifier(segueIdentifier: SegueIdentifier, sender: AnyObject?) {
        performSegueWithIdentifier(segueIdentifier.rawValue, sender: sender)
    }

    public func segueIdentifierForSegue(segue: UIStoryboardSegue) -> SegueIdentifier {
        guard let identifier = segue.identifier, segueIdentifier = SegueIdentifier(rawValue: identifier) else {
            fatalError("Invalid segue identifier: \(segue.identifier)")
        }

        return segueIdentifier
    }
}
