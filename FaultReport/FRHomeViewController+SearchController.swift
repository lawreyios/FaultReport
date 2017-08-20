//
//  FRHomeViewController+UISearchController.swift
//  FaultReport
//
//  Created by Lawrence Tan on 20/8/17.
//  Copyright © 2017 lawrey. All rights reserved.
//

import UIKit

extension FRHomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterViewModelsForSearchText(searchController.searchBar.text!)
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterViewModelsForSearchText(_ searchText: String) {
        if searchText.characters.count == 0 {
            filteredViewModels.removeAll()
            filteredViewModels.append(contentsOf: viewModels)
            return
        }
        
        filteredViewModels = viewModels.filter({( viewModel : IncidentViewModel) -> Bool in
            return viewModel.machineName.lowercased().contains(searchText.lowercased()) ||
                viewModel.incidentID.lowercased().contains(searchText.lowercased()) ||
                viewModel.location.lowercased().contains(searchText.lowercased())
        })
    }
}
