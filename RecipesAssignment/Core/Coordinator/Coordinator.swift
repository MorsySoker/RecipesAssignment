//
//  Coordinator.swift
//  RecipesAssignment
//
//  Created by MorsyElsokary on 20/10/2022.
//

import UIKit

protocol Coordinator {
    var childCoordinator: [Coordinator] { get set }
    var navController: BaseNavigationController { get set}
    
    func start()
}
