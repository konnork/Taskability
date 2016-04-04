//
//  CheckmarkView.swift
//  Taskability
//
//  Created by Connor Krupp on 17/03/2016.
//  Copyright © 2016 Connor Krupp. All rights reserved.
//

import UIKit

@IBDesignable
class Checkmark: UIControl {

    let checkmarkLayer = CAShapeLayer()

    @IBInspectable var isFilled: Bool = false {
        didSet {
            checkmarkLayer.strokeColor = strokeColor
        }
    }

    @IBInspectable var unfilledColor: UIColor = UIColor.blackColor() {
        didSet {
            checkmarkLayer.strokeColor = unfilledColor.CGColor
        }
    }

    @IBInspectable var filledColor: UIColor = UIColor.blueColor() {
        didSet {
            checkmarkLayer.strokeColor = filledColor.CGColor
        }
    }

    var strokeColor: CGColor {
        return isFilled ? filledColor.CGColor : unfilledColor.CGColor
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        layoutCheckmark()
    }

    func layoutCheckmark() {
        self.layer.addSublayer(checkmarkLayer)
        checkmarkLayer.strokeColor = strokeColor
        checkmarkLayer.fillColor = nil
        checkmarkLayer.lineWidth = 1.5

        let startX = self.bounds.midX + 11
        let startY = self.bounds.midY - 8

        let cornerX = startX - 15.0
        let cornerY = startY + 15.0

        let endX = cornerX - 7.0
        let endY = cornerY - 7.0

        let checkmarkPath = UIBezierPath()
        checkmarkPath.moveToPoint(CGPoint(x: startX, y: startY))
        checkmarkPath.addLineToPoint(CGPoint(x: cornerX, y: cornerY))
        checkmarkPath.addLineToPoint(CGPoint(x: endX, y: endY))

        checkmarkLayer.path = checkmarkPath.CGPath
    }

}
