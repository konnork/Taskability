//
//  WeightItem.swift
//  Weight Tracker
//
//  Created by Connor Krupp on 21/02/2016.
//  Copyright © 2016 Connor Krupp. All rights reserved.
//

import Foundation

public class WeightItem : NSObject {

    // MARK: Properties

    /// The mass for the weight item in kg
    private var mass: Double

    /// The date for the weight item
    private var date: NSDate

    /// The UUID for uniqueness between date items (beyond date)
    private var UUID: NSUUID

    // MARK:  Initializers

    /**
        Designated initializer for WeightItem.
        - parameter mass: Mass for the weight item (kg)
        - parameter date: Date for the weight item 
        - parameter UUID: The item's initial UUID
    */
    private init(mass: Double, date: NSDate, UUID: NSUUID) {
        self.mass = mass
        self.date = date
        self.UUID = UUID
    }

    /**
        Convenience initializer with designated mass and date
        - parameter mass: Mass for the weight item (kg)
        - parameter date: Date for the weight item
    */
    public convenience init(mass: Double, date: NSDate) {
        self.init(mass: mass, date: date, UUID: NSUUID())
    }

    /**
        Convenience initializer with designated mass
        - parameter mass: Mass for the weight item (kg)
    */
    public convenience init(mass: Double) {
        self.init(mass: mass, date: NSDate())
    }

    // MARK: Overrides

    // returns true if and only if the UUIDs are equal
    override public func isEqual(object: AnyObject?) -> Bool {
        if let item = object as? WeightItem {
            return UUID == item.UUID
        }

        return false
    }

    // MARK: DebugPrintable

    public override var debugDescription: String {
        return "Mass: \(mass), Date: \(date)"
    }
}