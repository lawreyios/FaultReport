//
//  FRIncidentTableViewCell.swift
//  FaultReport
//
//  Created by Lawrence Tan on 19/8/17.
//  Copyright © 2017 lawrey. All rights reserved.
//

import UIKit

class FRIncidentTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

extension FRIncidentTableViewCell: IncidentViewModelConfigurable {
    public func configure(viewModel: IncidentViewModel) {
        titleLabel.text = viewModel.incidentID
        subTitleLabel.text = viewModel.machineName
        dateLabel.text = viewModel.machineName
    }
}
