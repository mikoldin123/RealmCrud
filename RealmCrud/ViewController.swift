//
//  ViewController.swift
//  RealmCrud
//
//  Created by Michael Dean Villanda on 8/11/20.
//  Copyright © 2020 Michael Dean Villanda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var realm: RealmManagerSource {
        return RealmManager.shared
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let info: [String: Any] = ["id": "1", "firstName": "John", "lastName": "Weak"]
        
        guard let person = try? DictionaryDecoder().decode(Person.self, from: info) else {
            return
        }
        
        realm.create(person)
        
        guard let john = realm.fetch(Person.self).filter("id == %@", "1").first else {
            print("PERSON DOES NOT EXIST")
            return
        }
        
        print("SAVED PERSON: \(john)")
        
        let doggy: [String: Any] = ["name": "Doggy", "type": 0]
        
        realm.write { (_) in
            if let pet = try? DictionaryDecoder().decode(Pet.self, from: doggy) {
                pet.person = john
                john.pets.append(pet)
            }
            
            print("ADDED PET PERSON: \(john)")
        }
        
        realm.update(john, with: ["lastName": "Wick"], withRefresh: false)
        
        print("UPDATED PERSON: \(john)")
    }
}

