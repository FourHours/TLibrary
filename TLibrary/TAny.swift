//
//  TAny.swift
//  TLibrary
//
//  Created by Q Zhuang on 5/13/17.
//  Copyright © 2017 Q Zhuang. All rights reserved.
//

import Foundation

public enum TAny {
    case Int(Int)
    case String(String)
    case TableDataSource(TTableDataSource)
    case Font(UIFont)
    case Color(UIColor)

    public func color() -> UIColor {
        if case let TAny.Color(value) = self {
            return value
        }
        else {
            return TColor.almostBlack
        }
    }
    
    public func int() -> Int {
        if case let TAny.Int(value) = self {
            return value
        }
        else {
            return 0
        }
    }
    
    public func string() -> String {
        if case let TAny.String(value) = self {
            return value
        }
        else {
            return ""
        }
    }
    
    public func tableDataSource() -> TTableDataSource {
        if case let TAny.TableDataSource(value) = self {
            return value
        }
        else {
            return TTableDataSource()
        }
    }
    
    public func font() -> UIFont {
        if case let TAny.Font(value) = self {
            return value
        }
        else {
            return TFont.body
        }
    }

}
