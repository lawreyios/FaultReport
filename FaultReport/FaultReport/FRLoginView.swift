//
//  FRLoginView.swift
//  FaultReport
//
//  Created by Lawrence Tan on 17/8/17.
//  Copyright © 2017 lawrey. All rights reserved.
//

import UIKit
import Swinject

enum InputFieldsError: Error {
    case InvalidUsername
    case InvalidPassword
}

protocol FRLoginViewDelegate {
    func didTapLogin()
}

class FRLoginView: UIView {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var delegate: FRLoginViewDelegate?
    
    var alertViewHelper: FRAlertViewHelper! = {
        let container = Container()
        container.register(FRAlertViewHelper.self) { _ in FRAlertViewHelper() }
        return container.resolve(FRAlertViewHelper.self)
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.usernameTextField.placeholder = LoginUsernamePlaceholder
        self.passwordTextField.placeholder = LoginPasswordPlaceholder
    }
    
    @IBAction func onLogin(_ sender: UIButton) {
        do {
            try verifyInputFields()
        } catch InputFieldsError.InvalidUsername {
            alertViewHelper.showAlertWithMessage(AlertViewInvalidUsername, from: delegate as! UIViewController)
        } catch InputFieldsError.InvalidPassword {
            alertViewHelper.showAlertWithMessage(AlertViewInvalidPassword, from: delegate as! UIViewController)
        } catch {
            alertViewHelper.showAlertWithMessage(AlertViewInvalidInputs, from: delegate as! UIViewController)
        }
        
        delegate?.didTapLogin()
    }
    
    private func verifyInputFields() throws {
        guard let username = usernameTextField.text,
            username.isAtLeast8Characters,
            username.isAlphabetic else { throw InputFieldsError.InvalidUsername }
        
        guard let password = passwordTextField.text,
            password.isAtLeast8Characters else { throw InputFieldsError.InvalidPassword }
    }
    
}
