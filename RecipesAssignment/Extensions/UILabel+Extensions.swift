//
//  UILabel+Extensions.swift
//  POMacArch
//
//  Created by Mohamed gamal on 05/05/2021.
//  Copyright © 2021 POMac. All rights reserved.
//

import UIKit

extension UILabel {

    func set(text: String, linespacing: CGFloat = 4) {
        let attributedString = NSMutableAttributedString(string: text)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = linespacing
        paragraphStyle.alignment = textAlignment
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle,
                                      value: paragraphStyle,
                                      range: NSRange(location: 0, length: attributedString.length))
        self.attributedText = attributedString
    }
}
