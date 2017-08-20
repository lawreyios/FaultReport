//
//  UITextField+Extensions.swift
//  FaultReport
//
//  Created by Lawrence Tan on 19/8/17.
//  Copyright © 2017 lawrey. All rights reserved.
//

import UIKit

class RoundedTextField: UITextField {
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = DefaultCornerRadius
        
        let paddingView = UIView(frame: CGRect(x: 0,
                                               y: 0,
                                               width: DefaultSpacing,
                                               height: self.frame.height))
        
        self.leftView = paddingView
        self.leftViewMode = UITextFieldViewMode.always
    }
}

class RoundedBorderedTextField: RoundedTextField {
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = DefaultCornerRadius
        
        let paddingView = UIView(frame: CGRect(x: 0,
                                               y: 0,
                                               width: DefaultSpacing,
                                               height: self.frame.height))
        
        self.leftView = paddingView
        self.leftViewMode = UITextFieldViewMode.always
        
        self.layer.borderWidth = DefaultBorderWidth
        self.layer.borderColor = UIColor.gray.cgColor
        self.clipsToBounds = true
    }
}
