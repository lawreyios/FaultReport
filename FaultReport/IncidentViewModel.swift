//
//  FRIncidentViewModel.swift
//  FaultReport
//
//  Created by Lawrence Tan on 19/8/17.
//  Copyright © 2017 lawrey. All rights reserved.
//

import Foundation

protocol IncidentViewModelConfigurable: class {
    func configure(viewModel: IncidentViewModel)
}

public struct IncidentViewModel {
    var incidentID: String
    var machineName: String
    var dateCreated: Date
}
