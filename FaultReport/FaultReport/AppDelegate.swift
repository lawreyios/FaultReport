//
//  AppDelegate.swift
//  FaultReport
//
//  Created by Lawrence Tan on 17/8/17.
//  Copyright © 2017 lawrey. All rights reserved.
//

import UIKit
import Swinject

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
                
        Container.loggingFunction = nil
        
        let container = Container()
        container.register(FRViewControllerFactory.self) { _ in FRViewControllerFactory() }
        
        let viewControllerFactory = container.resolve(FRViewControllerFactory.self)!
        let firstViewController = viewControllerFactory.viewControllerFor(controllerClass: FRLoginViewController.self)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = firstViewController
        window?.makeKeyAndVisible()
        
        return true
    }
}

