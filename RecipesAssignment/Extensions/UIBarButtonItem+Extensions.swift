//
//  UIBarButton+Extensions.swift
//  POMacArch
//
//  Created by Mohamed gamal on 05/05/2021.
//  Copyright © 2021 POMac. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem {

    func setUnderlineTitle(title: String,
                           color: UIColor = #colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1),
                           font: UIFont) {
        let attributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.font: font,
        NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
        NSAttributedString.Key.foregroundColor: color
        ]
        self.setTitleTextAttributes(attributes, for: .normal)
        self.setTitleTextAttributes(attributes, for: .highlighted)
        self.setTitleTextAttributes(attributes, for: [])
    }
}
