//
//  FRHomeViewController.swift
//  FaultReport
//
//  Created by Lawrence Tan on 18/8/17.
//  Copyright © 2017 lawrey. All rights reserved.
//

import UIKit

class FRHomeViewController: UIViewController {

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
        
    }
}
