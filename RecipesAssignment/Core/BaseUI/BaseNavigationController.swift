//
//  BaseNavigationController.swift
//  RecipesAssignment
//
//  Created by MorsyElsokary on 21/10/2022.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isHidden = true
    }
}
