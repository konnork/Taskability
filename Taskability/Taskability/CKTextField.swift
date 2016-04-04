//
//  CKTextField.swift
//  Taskability
//
//  Created by Connor Krupp on 19/03/2016.
//  Copyright © 2016 Connor Krupp. All rights reserved.
//

import UIKit

@IBDesignable
class CKTextField: UITextField, UITextFieldDelegate {

    @IBInspectable var placeholderFontSize: CGFloat = 10.0 {
        didSet {
            placeholderLabel.font = UIFont.systemFontOfSize(placeholderFontSize)
        }
    }

    @IBInspectable var placeholderTextColor: UIColor = UIColor.grayColor() {
        didSet {
            placeholderLabel.textColor = placeholderTextColor
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        delegate = self
        layoutPlaceholderLabel()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()

        delegate = self
        layoutPlaceholderLabel()
    }

    var placeholderLabel = UILabel()

    var topConstraint = NSLayoutConstraint()
    var bottomConstraint = NSLayoutConstraint()

    func layoutPlaceholderLabel() {
        placeholderLabel.text = self.placeholder
        placeholderLabel.font = UIFont.systemFontOfSize(placeholderFontSize)
        placeholderLabel.textColor = placeholderTextColor
        placeholderLabel.sizeToFit()
        addSubview(placeholderLabel)

        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false

        topConstraint = placeholderLabel.topAnchor.constraintEqualToAnchor(self.topAnchor)
        bottomConstraint = placeholderLabel.bottomAnchor.constraintEqualToAnchor(self.bottomAnchor)

        NSLayoutConstraint.activateConstraints([
            placeholderLabel.leadingAnchor.constraintEqualToAnchor(self.leadingAnchor),
            bottomConstraint
        ])
    }

    // Disable drawing of placeholder, as I will be drawing it myself
    override func drawPlaceholderInRect(rect: CGRect) { }

    func textFieldDidBeginEditing(textField: UITextField) {

        if textField.text!.isEmpty {
            self.layoutIfNeeded()
            topConstraint.active = true
            bottomConstraint.active = false

            UIView.animateWithDuration(0.35, animations: {
                self.layoutIfNeeded()
            })
        }

    }

    func textFieldDidEndEditing(textField: UITextField) {

        if textField.text!.isEmpty {
            self.layoutIfNeeded()
            topConstraint.active = false
            bottomConstraint.active = true

            UIView.animateWithDuration(0.35, animations: {
                self.layoutIfNeeded()
            })
        }
    }


}
