//
//  UIView+Extensions.swift
//  TMDB-MVVM
//
//  Created by MorsyElsokary on 29/07/2022.
//

import Foundation
import UIKit

extension UIView {
    func setBorder(borderWidth: CGFloat = 1,
                   color: UIColor = .lightGray,
                   cornerRadius: CGFloat = 12) {
        layer.cornerRadius = cornerRadius
        layer.borderColor = color.cgColor
        layer.borderWidth = borderWidth
    }

    func roundCorners(corners: CACornerMask, radius: CGFloat) {
        layer.cornerRadius = radius
        layer.maskedCorners = corners
    }
    
    func roundCorners(radius: CGFloat) {
        layer.cornerRadius = radius
    }

    func addShadow(color: UIColor, alpha: CGFloat, xValue: CGFloat, yValue: CGFloat, blur: CGFloat) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = Float(alpha)
        self.layer.shadowOffset = CGSize(width: xValue, height: yValue)
        self.layer.shadowRadius = blur/2
    }

    func addViewWithAnimation(animationDuration: TimeInterval = 0.3) {
        self.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.alpha = 0
        UIView.animate(withDuration: animationDuration, animations: {
            self.alpha = 1
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
    }

    func removeViewWithAnimation(animationDuration: TimeInterval = 0.3) {
        UIView.animate(withDuration: animationDuration, animations: {
            self.alpha = 0
            self.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }, completion: { _ in
            self.removeFromSuperview()
        })
    }
    class func fromNib<T: UIView>() -> T {
           return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
       }
    
    // MARK: - Nib Identifier
    // Note: The Nib Assigned name must match it's class ViewModel
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
}
