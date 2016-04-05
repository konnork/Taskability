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


    // MARK: IBInspectables

    @IBInspectable var borderWidth: CGFloat = 1.0 {
        didSet { setNeedsDisplay() }
    }

    @IBInspectable var uncheckedColor: UIColor = UIColor.grayColor() {
        didSet { setNeedsDisplay() }
    }

    @IBInspectable var checkedColor: UIColor = UIColor.blueColor() {
        didSet { setNeedsDisplay() }
    }

    // MARK: Computed Properties

    var viewCenter: CGPoint {
        return convertPoint(center, fromView: superview)
    }

    var borderRadius: CGFloat {
        return min(bounds.size.width, bounds.size.height) / 2 - borderWidth
    }

    // MARK: Properties

    var isChecked = false {
        didSet { setNeedsDisplay() }
    }

    // MARK: Drawing

    override func drawRect(rect: CGRect) {
        let border = UIBezierPath(arcCenter: viewCenter, radius: borderRadius, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)

        border.lineWidth = borderWidth
        isChecked ? checkedColor.setFill() : uncheckedColor.setStroke()
        isChecked ? border.fill() : border.stroke()

        let checkmarkPath = UIBezierPath()
        checkmarkPath.lineWidth = 1.0
        let offset = borderRadius/4
        let longEdge = CGPoint(x: (viewCenter.x + borderRadius * sqrt(2)/2) - offset, y: (viewCenter.y - borderRadius * sqrt(2)/2) + offset)
        let corner = CGPoint(x: viewCenter.x - offset, y: viewCenter.y + offset)
        let shortEdge = CGPoint(x: 1.5*corner.x - 0.5*longEdge.x, y: (corner.y + longEdge.y)/2)
        checkmarkPath.moveToPoint(longEdge)
        checkmarkPath.addLineToPoint(corner)
        checkmarkPath.addLineToPoint(shortEdge)
        UIColor.whiteColor().setStroke()
        checkmarkPath.stroke()
    }


}
