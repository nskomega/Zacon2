//
//  AppDelegate.swift
//  Zacon
//
//  Created by Mikhail Danilov on 27.11.2020.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            
            if let window = appDelegate.window  {
                
                let vc = ModuleBuilder.logInVC()
                let navigationController = UINavigationController(rootViewController: vc)
                navigationController.setNavigationBarHidden(true, animated: false)
                window.rootViewController = navigationController
                window.makeKeyAndVisible()
            }
        }
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        return true
    }
}
