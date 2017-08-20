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
    @IBOutlet weak var emptyView: FREmptyView!
    
    var viewModels = [IncidentViewModel]() {
        didSet {
            emptyView.configure(isFiltered: false, shouldShow: viewModels.count == 0)
            tableView.reloadData()
        }
    }
    
    var filteredViewModels = [IncidentViewModel]() {
        didSet {
            emptyView.configure(isFiltered: true, shouldShow: filteredViewModels.count == 0)
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
    
    var searchController: UISearchController! = {
        let container = Container()
        container.register(UISearchController.self) { _ in UISearchController(searchResultsController: nil) }
        return container.resolve(UISearchController.self)
    }()
    
    var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    var addBarButton: UIBarButtonItem!
    
    override var title: String? {
        get { return HomeTitle }
        set { super.title = title }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        setupSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getIncidents()
    }
    
    private func setupNavigationBar() {
        addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onAddReport))
        addBarButton.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = addBarButton
    }
    
    private func setupTableView() {
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = HomeSearchPlaceholderText
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
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
    
    private func getViewModels(models: [IncidentModel]) -> [IncidentViewModel] {
        var viewModels = [IncidentViewModel]()
        for model in models {
            let newViewModel = IncidentViewModel(incidentID: model.incidentID,
                                                 machineName: model.machineName,
                                                 location: model.location,
                                                 dateCreated: model.dateCreated)
            viewModels.append(newViewModel)
        }
        
        return viewModels
    }
}


