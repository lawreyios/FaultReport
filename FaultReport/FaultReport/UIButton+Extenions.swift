//
//  UIButton+Extenions.swift
//  FaultReport
//
//  Created by Lawrence Tan on 19/8/17.
//  Copyright © 2017 lawrey. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = DefaultCornerRadius
        self.clipsToBounds = true
    }
}
