//
//  TAutoIncretmentInt.swift
//  TLibrary
//
//  Created by Q Zhuang on 5/14/17.
//  Copyright © 2017 Q Zhuang. All rights reserved.
//

import Foundation

public extension TAutoIncretmentInt {
    public static let key = "TAutoIncretmentInt"
}

public struct TAutoIncretmentInt {
    public static let sharedInstance = TAutoIncretmentInt()
    
    private init() {}

    public func getNewInt() -> Int {

        let defaults = UserDefaults.standard
        var value = defaults.integer(forKey: TAutoIncretmentInt.key)
        
        if value == 0 {
            value = 100
        }
        self.reset(baseValue: value + 1)
        
        return value
    }
    
    public func reset(baseValue: Int) {
        let defaults = UserDefaults.standard
        defaults.set(baseValue, forKey: TAutoIncretmentInt.key)
        defaults.synchronize()
    }
}
