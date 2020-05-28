//
//  RealmConfig.swift
//  RunApp
//
//  Created by Dumitru Catalin Vunvulea on 28/05/2020.
//  Copyright © 2020 Dumitru Catalin Vunvulea. All rights reserved.
//

import Foundation
import RealmSwift

class RealmConfig {
    
    static var runDataConfig: Realm.Configuration {
        let realmPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(REALM_RUN_CONFIG)
        let config = Realm.Configuration (
            fileURL: realmPath,
            schemaVersion: 0,
            migrationBlock:{ migration, oldSchemeVersion in
                if (oldSchemeVersion < 0) {
                    //Nothing to do
                    //Realm will automatically detect new properties and remove properties
                }
                
                
            })
        return config
    }
}
