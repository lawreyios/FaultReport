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
    
    var viewControllerFactory: FRViewControllerFactory! = {
        let container = Container()
        container.register(FRViewControllerFactory.self) { _ in FRViewControllerFactory() }
        return container.resolve(FRViewControllerFactory.self)
    }()
    
    @IBOutlet var loginView: FRLoginView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        loginView.delegate = self
    }

}

extension FRLoginViewController: FRLoginViewDelegate {
    func loginViewDidLoginSuccess() {
        if let homeScreen = viewControllerFactory.viewControllerFor(controllerClass: FRHomeViewController.self) {
            let navigationController = viewControllerFactory.mainNavigationController(with: homeScreen)
            present(navigationController, animated: true, completion: nil)
        }
    }
}
