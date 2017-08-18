//
//  FRRealmHelper.swift
//  FaultReport
//
//  Created by Lawrence Tan on 19/8/17.
//  Copyright © 2017 lawrey. All rights reserved.
//

import RealmSwift

extension Results {
    func toArray() -> [T] {
        return self.map{$0}
    }
}


class FRRealmHelper {
    func getAllIncidents() -> [IncidentModel] {
        do {
            let incidentsResults = try Realm().objects(IncidentModel.self)
            return incidentsResults.toArray()
        } catch {
            print("Error getting incients!")
            return [IncidentModel]()
        }
    }
}
