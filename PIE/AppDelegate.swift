//
//  AppDelegate.swift
//  PIE
//
//  Created by Karina on 8/21/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        let startViewController = StartViewController(nibName: "StartViewController", bundle: nil)
        let navigationController = UINavigationController(rootViewController: startViewController)
//        navigationController.navigationBar.barTintColor = .gray
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        CoreDataManager.sharedManager.saveContext()
    }

}

  

