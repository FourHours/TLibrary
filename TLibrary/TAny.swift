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

    case Array(Array<TAnyable>)
    case Dictionary([String: TAny])
    
    case Font(UIFont)
    case Color(UIColor)
    case Error(Error)

    case ViewController(UIViewController)
    
    case RealmModel(TBasicRealmModel)
    case TableModel(TTableModel)
    case TableRowModel(TTableRowModel)
    
    case Empty
}

public protocol TAnyable {
    func asTAnyObject() -> TAny
}

public extension TAny {
    public func realmModel() -> TBasicRealmModel {
        if case let TAny.RealmModel(value) = self {
            return value
        }
        else {
            return TBasicRealmModel()
        }
    }
    
    public func viewController() -> UIViewController {
        if case let TAny.ViewController(value) = self {
            return value
        }
        else {
            return UIViewController()
        }
    }
    
    public func dictionary() -> [String: TAny] {
        if case let TAny.Dictionary(value) = self {
            return value
        }
        else {
            return ["empty":TAny.Empty]
        }
    }
    
    
    public func array() -> Array<TAnyable> {
        if case let TAny.Array(value) = self {
            return value
        }
        else {
            return []
        }
    }
    
    
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
    
    public func tableModel() -> TTableModel {
        if case let TAny.TableModel(value) = self {
            return value
        }
        else {
            return TTableModel()
        }
    }
    
    public func tableRowModel() -> TTableRowModel {
        if case let TAny.TableRowModel(value) = self {
            return value
        }
        else {
            return TBasicTableRowModel(title: "empty", detailText: "empty")
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
    
    public func error() -> Error {
        if case let TAny.Error(value) = self {
            return value
        }
        else {
            return TBackendError.noError
        }
    }
}



extension Int: TAnyable {
    public func asTAnyObject() -> TAny {
        return TAny.Int(self)
    }
}

extension String: TAnyable {
    public func asTAnyObject() -> TAny {
        return TAny.String(self)
    }
}

extension Array: TAnyable {
    public func asTAnyObject() -> TAny {
        return TAny.Array(self as! Array<TAnyable>)
    }
}

extension UIViewController: TAnyable {
    public func asTAnyObject() -> TAny {
        return TAny.ViewController(self)
    }
}

extension UIFont: TAnyable {
    public func asTAnyObject() -> TAny {
        return TAny.Font(self)
    }
}

extension UIColor: TAnyable {
    public func asTAnyObject() -> TAny {
        return TAny.Color(self)
    }
}

extension Dictionary: TAnyable {
    public func asTAnyObject() -> TAny {
        return TAny.Dictionary(self as! [String : TAny])
    }
}

/*
extension Error: TAnyable {
    public func asTAnyObject() -> TAny {
        return TAny.Error(self)
    }
}
*/

extension TAny: ExpressibleByStringLiteral {
    public typealias UnicodeScalarLiteralType = StringLiteralType
    
    public init(stringLiteral value: StringLiteralType) {
        self = .String(value)
    }
    
    public init(unicodeScalarLiteral value: UnicodeScalarLiteralType) {
        self.init(stringLiteral: value)
    }
    
    public typealias ExtendedGraphemeClusterLiteralType = StringLiteralType
    public init(extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterLiteralType) {
        self.init(stringLiteral: value)
    }
    
    // the existing String-based initializer from above remains here
}
