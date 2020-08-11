//
//  Pet.swift
//  RealmCrud
//
//  Created by Michael Dean Villanda on 8/11/20.
//  Copyright © 2020 Michael Dean Villanda. All rights reserved.
//

import Foundation
import RealmSwift

enum PetType: Int {
    case dog
    case cat
    
    var type: String {
        switch self {
        case .cat:
            return "cat"
        default:
            return "dog"
        }
    }
}

final class Pet: Object, Codable {
    @objc var type: Int = 0
    @objc var name: String = ""
    
    var petType: String {
        return PetType(rawValue: type)?.type ?? "unknown"
    }
    
    @objc var person: Person?
}
