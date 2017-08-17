//
//  FRViewControllerFactory.swift
//  FaultReport
//
//  Created by Lawrence Tan on 17/8/17.
//  Copyright © 2017 lawrey. All rights reserved.
//

import UIKit
import SwinjectStoryboard

class FRViewControllerFactory: NSObject {
    
    func viewControllerFor(controllerClass: Any) -> UIViewController? {
        let controllerClassName = String(describing: controllerClass)
        return SwinjectStoryboard.create(name: String(describing: controllerClass), bundle: nil).instantiateViewController(withIdentifier: controllerClassName)
    }
    
    func mainNavigationController(with rootViewController: UIViewController) -> FRMainNavigationController {
        let navigationController = SwinjectStoryboard.create(name: String(describing: FRMainNavigationController.self), bundle: nil).instantiateViewController(withIdentifier: "FRMainNavigationController") as! FRMainNavigationController
        navigationController.viewControllers = [rootViewController]
        return navigationController
    }

}
