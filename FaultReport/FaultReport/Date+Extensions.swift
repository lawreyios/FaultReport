//
//  Date+Extensions.swift
//  FaultReport
//
//  Created by Lawrence Tan on 19/8/17.
//  Copyright © 2017 lawrey. All rights reserved.
//

import Foundation

extension Date {
    func toString() -> String {
        return DateFormatter.forSG().string(from: self)
    }
    
}
