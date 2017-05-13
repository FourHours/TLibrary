//
//  TChainable.swift
//  TLibrary
//
//  Created by Q Zhuang on 5/12/17.
//  Copyright © 2017 Q Zhuang. All rights reserved.
//

import Foundation

public protocol TMethodChain : class {
    func with(_ name: String, value: TAny) -> Self
    func end() // Silence warning
}

private struct AssociatedKey {
    static var properties = "properties"
}

public extension TMethodChain {
    var properties: [String: TAny] { // cat is *effectively* a stored property
        get {
            return AssociatedObject.get(base: self, key: &AssociatedKey.properties)
            { return [String: TAny]() } // Set the initial value of the var
        }
        set { AssociatedObject.set(base: self, key: &AssociatedKey.properties, value: newValue) }
    }
    
    public func with(_ name: String, value: TAny) -> Self{
        properties[name] = value
        return self
    }
    
    public func end() {
        assert(false, "must implement by the target class")
        return
    }
}
