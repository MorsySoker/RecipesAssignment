//
//  AppCoordinator.swift
//  RecipesAssignment
//
//  Created by MorsyElsokary on 24/10/2022.
//

import UIKit


class AppCoordinator: Coordinator {
    
    var childCoordinator: [Coordinator] = [Coordinator]()
    let window: UIWindow
    var navController: BaseNavigationController
    
    init(presenting navigationController: BaseNavigationController, In window: UIWindow) {
        self.navController = navigationController
        self.window = window
    }
    
    func start() {
        showSplash()
    }
    
    private func showSplash() {
        navController.pushViewController(SplashView(), animated: true)
    }
}
