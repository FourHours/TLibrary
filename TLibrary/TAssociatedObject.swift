//
//  TAssociatedObject.swift
//  TLibrary
//
//  Created by Q Zhuang on 5/12/17.
//  Copyright © 2017 Q Zhuang. All rights reserved.
//

import Foundation

struct AssociatedObject {
    
    static func get<ValueType: Any>(base: Any, key: UnsafeRawPointer, initialiser: () -> ValueType)
        -> ValueType {
            if let associated = objc_getAssociatedObject(base, key)
                as? ValueType { return associated }
            
            let associated = initialiser()
            objc_setAssociatedObject(base, key, associated,
                                     .OBJC_ASSOCIATION_RETAIN)
            return associated
    }
    static func set<ValueType: Any>(base: Any, key: UnsafeRawPointer, value: ValueType) {
        objc_setAssociatedObject(base, key, value,
                                 .OBJC_ASSOCIATION_RETAIN)
    }
}
