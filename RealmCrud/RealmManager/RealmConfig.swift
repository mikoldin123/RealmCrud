//
//  RealmConfig.swift
//  RealmCrud
//
//  Created by Michael Dean Villanda on 8/11/20.
//  Copyright © 2020 Michael Dean Villanda. All rights reserved.
//

import Foundation
import RealmSwift

class RealmConfig {
    static let shared = RealmConfig()
    
    var currentSchemaVersion: UInt64 = 1
    
    func configureRealm() {
        let config = Realm.Configuration(
        // Set the new schema version. This must be greater than the previously used
        // version (if you've never set a schema version before, the version is 1).
        schemaVersion: currentSchemaVersion,
        migrationBlock: { [weak self] migration, oldSchemaVersion in
            guard let this = self else {
                return
            }
          
            // Add migration here
            if oldSchemaVersion < this.currentSchemaVersion {
                // Example
                /*migration.enumerateObjects { (old, new) in
                    
                }*/
            }
        })
          
        Realm.Configuration.defaultConfiguration = config
    }
}
