//
//  Realm+Extensions.swift
//  RealmCrud
//
//  Created by Michael Dean Villanda on 8/11/20.
//  Copyright © 2020 Michael Dean Villanda. All rights reserved.
//

import Foundation
import RealmSwift

extension Realm {
    static var defaultRealm: Realm {
        // Add custom realm config to fetch here
        do {
            return try Realm()
        } catch {
            fatalError("Unble to initalize realm -- \(error)")
        }
    }
    
    public func safeWrite(_ block: (() throws -> Void)) throws {
        if isInWriteTransaction {
            try block()
        } else {
            try write(block)
        }
    }
}
