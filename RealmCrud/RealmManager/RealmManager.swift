//
//  RealmManager.swift
//  RealmCrud
//
//  Created by Michael Dean Villanda on 24/03/2020.
//  Copyright © 2020 Viyahe. All rights reserved.
//

import Foundation
import RealmSwift

protocol RealmManagerSource: class {
    // MARK: - Insert
    func create<T: Object>(_ object: T)
    func create<T: Object>(_ objects: [T])
    
    // MARK: - Fetch
    func fetch<T: Object>(_ object: T.Type) -> Results<T>
    func fetchForType<T: Object, KeyType>(_ type: T.Type, withKey key: KeyType) -> T?
    
    // MARK: - Update
    func update<T: Object>(_ object: T, with dictionary: [String: Any], withRefresh refresh: Bool)
    func delete<T: Object>(_ object: T)
    
    func write(_ handler: (_ realm: Realm) -> Void)

    // MARK: - Error
    func logError(_ error: Error)
}

class RealmManager: RealmManagerSource {
    
    static let shared = RealmManager()
    
    // MARK: - INSERT
    func create<T: Object>(_ object: T) {
        let realm = Realm.defaultRealm
        
        do {
            try realm.safeWrite {
                realm.add(object, update: .all)
            }
        } catch {
            logError(error)
        }
    }
    
    func create<T: Object>(_ objects: [T]) {
        let realm = Realm.defaultRealm
        
        do {
            try realm.safeWrite {
                realm.add(objects, update: .all)
            }
        } catch {
            logError(error)
        }
    }
    
    // MARK: - FETCH
    func fetch<T: Object>(_ object: T.Type) -> Results<T> {
        let realm = Realm.defaultRealm
        
        let result = realm.objects(object)
        return result
    }

    func fetchForType<T, KeyType>(_ type: T.Type, withKey key: KeyType) -> T? where T: Object {
        let realm = Realm.defaultRealm
        
        return realm.object(ofType: type, forPrimaryKey: key)
    }

    // MARK: - UPDATE
    func update<T: Object>(_ object: T, with dictionary: [String: Any], withRefresh refresh: Bool) {
        let realm = Realm.defaultRealm
        
        if object.isInvalidated {
            return
        }

        if refresh {
            realm.refresh()
        }

        do {
            try realm.safeWrite {
                dictionary.forEach { item in
                    object.setValue(item.value, forKey: item.key)
                }
            }
        } catch {
            logError(error)
        }
    }
    
    func delete<T: Object>(_ object: T) {
        let realm = Realm.defaultRealm
        
        if object.isInvalidated {
            return
        }
        
        do {
            try realm.safeWrite {
                realm.delete(object)
            }
        } catch {
            logError(error)
        }
    }
    
    func write(_ handler: (_ realm: Realm) -> Void) {
        let realm = Realm.defaultRealm
        
        do {
            try realm.safeWrite {
                handler(realm)
            }
        } catch {
            logError(error)
        }
    }
    
    // MARK: - Error
    func logError(_ error: Error) {
//        BugsManager.logError(error)
        print("error: \(error)")
    }
}
