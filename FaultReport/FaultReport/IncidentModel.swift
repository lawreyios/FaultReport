//
//  IncidentModel.swift
//  FaultReport
//
//  Created by Lawrence Tan on 19/8/17.
//  Copyright © 2017 lawrey. All rights reserved.
//

import Foundation
import RealmSwift

class IncidentModel: Object {
    dynamic var incidentID: String!
    dynamic var machineName: String!
    dynamic var desc: String!
    dynamic var location: String!
    dynamic var dateCreated: Date!
    
    convenience init(machineName: String, desc: String, location: String) {
        self.init()
        self.incidentID = "FR\(Int(ceil(Date().timeIntervalSince1970)))"
        self.machineName = machineName
        self.desc = desc
        self.location = location
        self.dateCreated = Date()
    }
    
    override static func primaryKey() -> String? {
        return "incidentID"
    }
    
    func save() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(self)
            }
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
}
