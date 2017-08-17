//
//  String+Extensions.swift
//  FaultReport
//
//  Created by Lawrence Tan on 18/8/17.
//  Copyright © 2017 lawrey. All rights reserved.
//

import Foundation

extension String {
    var isAlphabetic: Bool {
        return !isEmpty && range(of: "[0-9]", options: .regularExpression) == nil
    }
    
    var isAtLeast8Characters: Bool {
        return characters.count >= 8
    }
}
