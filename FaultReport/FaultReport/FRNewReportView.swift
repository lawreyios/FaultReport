//
//  FRNewReportView.swift
//  FaultReport
//
//  Created by Lawrence Tan on 18/8/17.
//  Copyright © 2017 lawrey. All rights reserved.
//

import UIKit
import Swinject

enum NewReportInputFieldsError: Error {
    case InvalidName
    case InvalidLocation
    case InvalidDescription
}

protocol FRNewReportViewDelegate {
    func newReportViewDidAddNewReportSuccess()
}

class FRNewReportView: UIView {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var descriptionTextView: BorderedTextView!
    
    var delegate: FRNewReportViewDelegate?
    
    var alertViewHelper: FRAlertViewHelper! = {
        let container = Container()
        container.register(FRAlertViewHelper.self) { _ in FRAlertViewHelper() }
        return container.resolve(FRAlertViewHelper.self)
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func onSubmit(_ sender: Any) {
        do {
            try verifyInputFields()
        } catch NewReportInputFieldsError.InvalidName {
            alertViewHelper.showAlertWithMessage(AlertViewInvalidUsernameMessage, from: delegate as! UIViewController)
            return
        } catch NewReportInputFieldsError.InvalidLocation {
            alertViewHelper.showAlertWithMessage(AlertViewInvalidPasswordMessage, from: delegate as! UIViewController)
            return
        } catch NewReportInputFieldsError.InvalidDescription {
            alertViewHelper.showAlertWithMessage(AlertViewInvalidDescriptionMessage, from: delegate as! UIViewController)
            return
        } catch {
            alertViewHelper.showAlertWithMessage(AlertViewInvalidNewReportInputsMessage, from: delegate as! UIViewController)
            return
        }
        
        guard
            let name = nameTextField.text,
            let location = locationTextField.text,
            let description = descriptionTextView.text else { return }
        
        let newIncidentReport = IncidentModel(machineName: name, desc: description, location: location)
        newIncidentReport.save()
        
        let submittedMessage = String.init(format: "Your report is submitted successfully.\nYour Incident ID is %@", arguments: [newIncidentReport.incidentID!])
        alertViewHelper.showAlertWithMessage(submittedMessage, from: delegate as! UIViewController) { [weak self] (action) in
            self?.delegate?.newReportViewDidAddNewReportSuccess()
        }
    }
    
    private func verifyInputFields() throws {
        guard let
            name = nameTextField.text,
            !name.isEmpty else { throw NewReportInputFieldsError.InvalidName }
        
        guard let
            location = locationTextField.text,
            !location.isEmpty else { throw NewReportInputFieldsError.InvalidLocation }
        
        guard let
            description = descriptionTextView.text,
            description.isAtLeast8Characters else { throw NewReportInputFieldsError.InvalidDescription }
    }
}
