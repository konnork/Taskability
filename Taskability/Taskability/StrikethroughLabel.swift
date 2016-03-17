//
//  StrikethroughLabel.swift
//  Taskability
//
//  Created by Connor Krupp on 17/03/2016.
//  Copyright © 2016 Connor Krupp. All rights reserved.
//

import UIKit

class StrikethroughLabel: UILabel {

    var shouldStrike = false {
        didSet {
            updateStrike()
        }
    }

    override var text: String? {
        didSet {
            updateStrike()
        }
    }

    func updateStrike() {
        if let text = text {
            if shouldStrike {
                self.attributedText = NSAttributedString(string: text, attributes: [NSStrikethroughStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue])
            } else {
                self.attributedText = NSAttributedString(string: text)
            }
        }
    }

}
