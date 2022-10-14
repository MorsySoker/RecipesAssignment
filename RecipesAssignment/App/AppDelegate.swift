//
//  AppDelegate.swift
//  RecipesAssignment
//
//  Created by MorsyElsokary on 24/08/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let vc = SplashView()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setMainInterface()
        return true
    }
    
    private func setMainInterface() {
        
        let navigation = UINavigationController(
            rootViewController: vc)
        navigation.navigationBar.isHidden = true
        let frame = UIScreen.main.bounds
        window = UIWindow(frame: frame)

        window!.rootViewController = navigation
        window!.makeKeyAndVisible()
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        vc.applicationDidEnterBackground(application)
    }
}

