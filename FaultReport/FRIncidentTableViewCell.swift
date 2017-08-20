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
    @IBOutlet weak var locationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = UIFont.h1()
        subTitleLabel.font = UIFont.h2()
        dateLabel.font = UIFont.h3()
        locationLabel.font = UIFont.h3()
    }
}

extension FRIncidentTableViewCell: IncidentViewModelConfigurable {
    public func configure(viewModel: IncidentViewModel) {
        titleLabel.text = viewModel.incidentID
        subTitleLabel.text = viewModel.machineName
        dateLabel.text = viewModel.dateCreated.toString()
        locationLabel.text = viewModel.location
    }
}
