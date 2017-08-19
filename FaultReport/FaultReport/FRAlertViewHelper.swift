//
//  FRAlertViewHelper.swift
//  FaultReport
//
//  Created by Lawrence Tan on 18/8/17.
//  Copyright © 2017 lawrey. All rights reserved.
//

import UIKit
import Swinject

typealias ActionBlock = (UIAlertAction) -> Void

class FRAlertViewHelper: NSObject {
    
    func showAlertWithMessage(_ message: String, from target: UIViewController) {
        let alertViewController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        target.present(alertViewController, animated: true, completion: nil)
    }
    
    func showAlertWithMessage(_ message: String, from target: UIViewController, actionBlock: @escaping ActionBlock) {
        let alertViewController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "Ok", style: .default, handler: actionBlock))
        target.present(alertViewController, animated: true, completion: nil)
    }

}
