//
//  AppDelegate.swift
//  WunderTestApp
//
//  Created by Nikita Kechinov on 24.09.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import UIKit
import GoogleMaps

let apiKey = "AIzaSyBUeAcQSqm-8G6vUuIsRnKS6KMfnHhSy0A"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        GMSServices.provideAPIKey(apiKey)

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: ParentViewController())
        
        UIApplication.shared.statusBarStyle = .lightContent
        UINavigationBar.appearance().barTintColor = #colorLiteral(red: 0.1212523794, green: 0.1212523794, blue: 0.1212523794, alpha: 1)
        UINavigationBar.appearance().tintColor = #colorLiteral(red: 0.9664102157, green: 0.9664102157, blue: 0.9664102157, alpha: 1)
        UINavigationBar.appearance().isTranslucent = false
        
        if let segControlFont = UIFont(name: "OpenSans", size: 15) {
            let segControlAttributesDictionary: [NSAttributedStringKey: Any] = [
                NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): #colorLiteral(red: 0.9664102157, green: 0.9664102157, blue: 0.9664102157, alpha: 1),
                NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue): segControlFont]
            UISegmentedControl.appearance().setTitleTextAttributes(segControlAttributesDictionary, for: .normal)
            
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {}
    func applicationDidEnterBackground(_ application: UIApplication) {}
    func applicationWillEnterForeground(_ application: UIApplication) {}
    func applicationDidBecomeActive(_ application: UIApplication) {}
    func applicationWillTerminate(_ application: UIApplication) {}
        
}

