//
//  FRReportViewController.swift
//  FaultReport
//
//  Created by Lawrence Tan on 18/8/17.
//  Copyright © 2017 lawrey. All rights reserved.
//

import UIKit
import Swinject

class FRNewReportViewController: UIViewController {
    
    var viewControllerFactory: FRViewControllerFactory! = {
        let container = Container()
        container.register(FRViewControllerFactory.self) { _ in FRViewControllerFactory() }
        return container.resolve(FRViewControllerFactory.self)
    }()
    
    override var title: String? {
        get { return NewReportTitle }
        set { super.title = title }
    }
    
    @IBOutlet var newReportView: FRNewReportView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        newReportView.delegate = self
    }
}

extension FRNewReportViewController: FRNewReportViewDelegate {
    func newReportViewDidAddNewReportSuccess() {
        navigationController?.popViewController(animated: true)
    }
}
