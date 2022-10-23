//
//  AppDelegate.swift
//  RecipesAssignment
//
//  Created by MorsyElsokary on 24/08/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private var appCoordinator: Coordinator!
    private var navController: BaseNavigationController!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        navController = BaseNavigationController()
        let frame = UIScreen.main.bounds
        let window = UIWindow(frame: frame)
        window.rootViewController = navController
        window.makeKeyAndVisible()
        appCoordinator = AppCoordinator(presenting: navController, In: window)
        appCoordinator.start()

        return true
    }
}

