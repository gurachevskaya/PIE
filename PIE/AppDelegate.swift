//
//  AppDelegate.swift
//  PIE
//
//  Created by Karina on 8/21/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        
        let navigationBarAppearance = UINavigationBar.appearance()
        navigationBarAppearance.tintColor = UIColor(named: "accentColor")
        let tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.tintColor = UIColor(named: "accentColor")
        
        let tabBarController = UITabBarController()
        
        let searchOptionsVC = StartViewController(nibName: "StartViewController", bundle: nil)
        searchOptionsVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "search"), tag: 0)
        let searchNC = UINavigationController(rootViewController: searchOptionsVC)
        searchNC.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        let favouritesVC = RecipesViewControllerFactory().makeRecipeViewController(type: .favouriteRecipes)
        favouritesVC.tabBarItem = UITabBarItem(title: "Favourites", image: UIImage(named: "star"), tag: 1)
        let favouritesNC = UINavigationController(rootViewController: favouritesVC)
        favouritesNC.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        tabBarController.viewControllers = [searchNC, favouritesNC]
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }
    
    
    func applicationWillTerminate(_ application: UIApplication) {
        saveContext()
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "PIE")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}



