//
//  FRHomeViewController+TableView.swift
//  FaultReport
//
//  Created by Lawrence Tan on 19/8/17.
//  Copyright © 2017 lawrey. All rights reserved.
//

import UIKit

extension FRHomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredViewModels.count : viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel(for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "FRIncidentTableViewCell", for: indexPath)
        configure(cell: cell, viewModel: item)
        return cell
    }
}

fileprivate extension FRHomeViewController {
    func viewModel(for indexPath: IndexPath) -> IncidentViewModel {
        return isFiltering ? filteredViewModels[indexPath.row] : viewModels[indexPath.row]
    }
    
    func configure(cell: UITableViewCell, viewModel: IncidentViewModel) {
        if let cell = cell as? IncidentViewModelConfigurable {
            cell.configure(viewModel: viewModel)
        }
    }
}
