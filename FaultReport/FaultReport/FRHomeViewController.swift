//
//  FRHomeViewController.swift
//  FaultReport
//
//  Created by Lawrence Tan on 18/8/17.
//  Copyright © 2017 lawrey. All rights reserved.
//

import UIKit
import Swinject

class FRHomeViewController: UIViewController {
    
    var viewControllerFactory: FRViewControllerFactory! = {
        let container = Container()
        container.register(FRViewControllerFactory.self) { _ in FRViewControllerFactory() }
        return container.resolve(FRViewControllerFactory.self)
    }()
    
    override var title: String? {
        get { return HomeTitle }
        set { super.title = title }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        let addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onAddReport))
        addBarButton.tintColor = UIColor.black
        navigationItem.rightBarButtonItem = addBarButton
    }
    
    func onAddReport() {
        let newReportScreen = viewControllerFactory.viewControllerFor(controllerClass: FRNewReportViewController.self) as! FRNewReportViewController
        navigationController?.pushViewController(newReportScreen, animated: true)
    }
}
