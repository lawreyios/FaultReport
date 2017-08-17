//
//  FRAlertViewHelper.swift
//  FaultReport
//
//  Created by Lawrence Tan on 18/8/17.
//  Copyright © 2017 lawrey. All rights reserved.
//

import UIKit
import Swinject

class FRAlertViewHelper: NSObject {
    
    func showAlertWithMessage(_ message: String, from target: UIViewController) {
        let alertViewController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        target.present(alertViewController, animated: true, completion: nil)
    }

}
