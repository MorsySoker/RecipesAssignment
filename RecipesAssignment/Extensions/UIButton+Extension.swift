//
//  UIButton+Extension.swift
//  POMacArch
//
//  Created by Mohamed gamal on 05/05/2021.
//  Copyright © 2021 POMac. All rights reserved.
//

import UIKit

extension UIButton {
    
    func setTitleColor(_ color: UIColor) {
        self.setTitleColor(color, for: .normal)
        self.setTitleColor(color, for: .selected)
        self.setTitleColor(color, for: .highlighted)
    }
    
    func setTitle(_ title: String) {
        self.setTitle(title, for: .normal)
        self.setTitle(title, for: .selected)
        self.setTitle(title, for: .highlighted)
    }
    
    func setAttributedTitle(_ attributedString: NSAttributedString) {
        self.setAttributedTitle(attributedString,
                                for: .normal)
        self.setAttributedTitle(attributedString,
                                for: .selected)
        self.setAttributedTitle(attributedString,
                                for: .highlighted)
    }
}
