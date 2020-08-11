//
//  Person.swift
//  RealmCrud
//
//  Created by Michael Dean Villanda on 8/11/20.
//  Copyright © 2020 Michael Dean Villanda. All rights reserved.
//

import Foundation
import RealmSwift

final class Person: Object, Codable {
    @objc dynamic var id: String = ""
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    let pets = List<Pet>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
