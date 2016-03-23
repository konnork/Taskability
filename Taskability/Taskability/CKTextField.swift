//
//  CKTextField.swift
//  Taskability
//
//  Created by Connor Krupp on 19/03/2016.
//  Copyright © 2016 Connor Krupp. All rights reserved.
//

import UIKit

class CKTextField: UITextField, UITextFieldDelegate {

    override init(frame: CGRect) {
        super.init(frame: frame)
        delegate = self

        layoutPlaceholderLabel()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate = self

        layoutPlaceholderLabel()
    }


    var placeholderLabel = UILabel()

    var topConstraint = NSLayoutConstraint()
    var bottomConstraint = NSLayoutConstraint()

    func layoutPlaceholderLabel() {
        placeholderLabel.text = placeholder
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(placeholderLabel)

        placeholderLabel.sizeToFit()
        placeholderLabel.font = UIFont.systemFontOfSize(12.0)

        topConstraint = placeholderLabel.topAnchor.constraintEqualToAnchor(self.topAnchor)
        bottomConstraint = placeholderLabel.bottomAnchor.constraintEqualToAnchor(self.bottomAnchor, constant: -10)
        NSLayoutConstraint.activateConstraints([
            placeholderLabel.leadingAnchor.constraintEqualToAnchor(self.leadingAnchor),
            bottomConstraint
        ])

    }

    // Disable drawing of placeholder, as I will be drawing it myself
    override func drawPlaceholderInRect(rect: CGRect) { }

    func textFieldDidBeginEditing(textField: UITextField) {

        topConstraint.active = true
        bottomConstraint.active = false

        UIView.animateWithDuration(0.2, animations: {
            self.layoutIfNeeded()
        })

    }

    func textFieldDidEndEditing(textField: UITextField) {
        self.layoutIfNeeded()
        topConstraint.active = false
        bottomConstraint.active = true

        UIView.animateWithDuration(0.2, animations: {
            self.layoutIfNeeded()
        })
    }


}
