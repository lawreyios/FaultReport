//
//  UITextView+Extensions.swift
//  FaultReport
//
//  Created by Lawrence Tan on 19/8/17.
//  Copyright © 2017 lawrey. All rights reserved.
//

import UIKit

class BorderedTextView: UITextView {
    
    override func draw(_ rect: CGRect) {
        self.layer.borderWidth = DefaultBorderWidth;
        self.layer.borderColor = UIColor.gray.cgColor
        
        self.layer.cornerRadius = DefaultSpacing
        
        self.textContainerInset = UIEdgeInsetsMake(DefaultSpacing,
                                                   DefaultSpacing,
                                                   DefaultSpacing,
                                                   DefaultSpacing)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
