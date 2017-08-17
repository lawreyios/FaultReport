//
//  FRLoginViewController.swift
//  FaultReport
//
//  Created by Lawrence Tan on 17/8/17.
//  Copyright © 2017 lawrey. All rights reserved.
//

import UIKit
import Swinject

class FRLoginViewController: UIViewController {
    
    let container = Container()
    
    var viewControllerFactory: FRViewControllerFactory!

    override func viewDidLoad() {
        super.viewDidLoad()
        container.register(FRViewControllerFactory.self) { _ in FRViewControllerFactory() }
        viewControllerFactory = container.resolve(FRViewControllerFactory.self)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let vc = viewControllerFactory.viewControllerFor(controllerClass: FRLoginViewController.self)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
