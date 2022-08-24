//
//  UINavigationController+Extensions.swift
//  POMacArch
//
//  Created by Mohamed gamal on 05/05/2021.
//  Copyright © 2021 POMac. All rights reserved.
//

import UIKit

extension UINavigationController {

    func setNavigationBar(bgColor: UIColor, tintColor: UIColor) {
        self.navigationBar.barTintColor = bgColor
        self.navigationBar.tintColor = tintColor
    }

    func popViewControllers(controllersToPop: Int, animated: Bool) {
        if viewControllers.count > controllersToPop {
            popToViewController(viewControllers[viewControllers.count - (controllersToPop + 1)], animated: animated)
            return
        }
        print("Trying to pop \(controllersToPop) view controllers but navigation controller contains only \(viewControllers.count) controllers in stack")
    }
}
