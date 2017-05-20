//
//  TRealm.swift
//  TLibrary
//
//  Created by Q Zhuang on 5/14/17.
//  Copyright © 2017 Q Zhuang. All rights reserved.
//

import Foundation
import RealmSwift

public extension TRealm {
    public enum PropertyName {
        public static let dataSource = "dataSource"
        
    }
    
    public enum EventName {
        public static let onError = "onError"
        public static let onResponse = "onResponse"
        
        public static let toAdd = "toAdd"
        public static let toUpdate = "toAdd"
        public static let toDelete = "toAdd"


        
    }
    public enum TableCellType: Int {
        case Value1 = 1
        case Nib
        case Dynamic
    }
}

public final class TRealm: TEventEmitter {
    public static let sharedInstance = TRealm()

    private init() {
        self.on(TRealm.EventName.toAdd) { (realmModels) in
            
            let realm = try! Realm()
            
            try! realm.write {
                realmModels.array().forEach({ (anyableObject) in
                    realm.add(anyableObject.asTAnyObject().realmModel())
                })
            }

            print("toAdd Finished")
        }
            .on(TRealm.EventName.toUpdate) { (object) in
                print("toUpdate \(object)")
        }
            .on(TRealm.EventName.toDelete) { (object) in
                print("toDelete \(object)")
        }
        .end()
    }

    public func config(versionMumber: Int) {
        
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: UInt64(versionMumber),
            
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if (oldSchemaVersion < 1) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
        })
        
        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
    }

    public func fetchAll<T: Object>(_ type: T.Type) {
        
        // public final class Results<T: Object>: NSObject, NSFastEnumeration
        // https://realm.io/docs/swift/latest/api/Classes/Results.html
        // Results<T>

        TDispatch.sharedInstance.async {
            let realm = try! Realm()
            
            let objectList: [TBasicRealmModel] = realm.objects(type).map({ model in
                return model as! TBasicRealmModel
            })
            
            self.emit(TRealm.EventName.onResponse, data: TAny.Array(objectList))
        }

    }
    
    public func loadTestData() {
        
    }
    
    public func end() {
    }
}
