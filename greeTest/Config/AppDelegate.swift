//
//  AppDelegate.swift
//  greeTest
//
//  Created by mac on 2021/10/16.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var windows = UIWindow()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        windows = UIWindow(frame: UIScreen.main.bounds)
        windows.backgroundColor = .white
        let vc = ViewController()
        let navi = UINavigationController(rootViewController: vc)
        windows.rootViewController = navi
        windows.makeKeyAndVisible()
        
        
        
        
        return true
    }



}

