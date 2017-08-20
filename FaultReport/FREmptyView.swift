//
//  FREmptyView.swift
//  FaultReport
//
//  Created by Lawrence Tan on 20/8/17.
//  Copyright © 2017 lawrey. All rights reserved.
//

import UIKit

class FREmptyView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(isFiltered: Bool, shouldShow: Bool) {
        titleLabel.text = isFiltered ? EmptyViewNoResultsText : EmptyViewNoIncidentText
        isHidden = shouldShow ? false : true
    }

}
