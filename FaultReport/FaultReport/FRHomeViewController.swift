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
    
    var filteredViewModels = [IncidentViewModel]() {
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
    
    var searchController: UISearchController! = {
        let container = Container()
        container.register(UISearchController.self) { _ in UISearchController(searchResultsController: nil) }
        return container.resolve(UISearchController.self)
    }()
    
    var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
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
        let addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onAddReport))
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
        searchController.searchBar.placeholder = "Search incident by ID, name or location ..."
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }
    
    func onAddReport() {
        let newReportScreen = viewControllerFactory.viewControllerFor(controllerClass: FRNewReportViewController.self) as! FRNewReportViewController
        navigationController?.pushViewController(newReportScreen, animated: true)
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterViewModelsForSearchText(_ searchText: String) {
        filteredViewModels = viewModels.filter({( viewModel : IncidentViewModel) -> Bool in
            return viewModel.machineName.lowercased().contains(searchText.lowercased()) ||
                viewModel.incidentID.lowercased().contains(searchText.lowercased()) ||
                viewModel.location.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
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
                                                 location: model.location,
                                                 dateCreated: model.dateCreated)
            viewModels.append(newViewModel)
        }
        
        return viewModels
    }
}

extension FRHomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterViewModelsForSearchText(searchController.searchBar.text!)
    }
}
