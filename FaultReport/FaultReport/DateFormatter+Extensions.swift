//
//  DateFormatter+Extensions.swift
//  FaultReport
//
//  Created by Lawrence Tan on 19/8/17.
//  Copyright © 2017 lawrey. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    static func forSG() -> DateFormatter {
        let dateFormatter = DateFormatter()
        if let timeZone = TimeZone.init(identifier: "Asia/Singapore") {
            dateFormatter.timeZone = timeZone
        }
        dateFormatter.dateFormat = "MMM d, h:mm a"
        
        return dateFormatter
    }
}
