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
    
    @IBOutlet var tableView: UITableView!
    
    var viewModels = [IncidentViewModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var viewControllerFactory: FRViewControllerFactory! = {
        let container = Container()
        container.register(FRViewControllerFactory.self) { _ in FRViewControllerFactory() }
        return container.resolve(FRViewControllerFactory.self)
    }()
    
    var realmHelper: FRRealmHelper! = {
        let container = Container()
        container.register(FRRealmHelper.self) { _ in FRRealmHelper() }
        return container.resolve(FRRealmHelper.self)
    }()
    
    override var title: String? {
        get { return HomeTitle }
        set { super.title = title }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getIncidents()
    }
    
    private func setupNavigationBar() {
        let addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onAddReport))
        addBarButton.tintColor = UIColor.black
        navigationItem.rightBarButtonItem = addBarButton
    }
    
    private func setupTableView() {
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func onAddReport() {
        let newReportScreen = viewControllerFactory.viewControllerFor(controllerClass: FRNewReportViewController.self) as! FRNewReportViewController
        navigationController?.pushViewController(newReportScreen, animated: true)
    }
}

fileprivate extension FRHomeViewController {
    func getIncidents() {
        let incidents = realmHelper.getAllIncidents()
        viewModels = getViewModels(models: incidents)
    }
    
    func getViewModels(models: [IncidentModel]) -> [IncidentViewModel] {
        var viewModels = [IncidentViewModel]()
        for model in models {
            let newViewModel = IncidentViewModel(incidentID: model.incidentID,
                                                 machineName: model.machineName,
                                                 dateCreated: model.dateCreated)
            viewModels.append(newViewModel)
        }
        
        return viewModels
    }
}
