//
//  CoordinatorProtocols.swift
//  RecipesAssignment
//
//  Created by MorsyElsokary on 20/10/2022.
//

import UIKit

protocol Coordinator {
    func start()
}

class AppCoordinator: Coordinator {
    
    let window: UIWindow
    var navContrroler: BaseNavigationController!
    
    init(presenting navigationController: BaseNavigationController, In window: UIWindow) {
        self.window = window
        self.navContrroler = navigationController
    }
    
    func start() {
        showSplash()
    }
    
    private func showSplash() {
        navContrroler.pushViewController(SplashView(), animated: true)
    }
}
