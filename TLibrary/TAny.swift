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
    case TableModel(TTableModel)
    case TableRowModel(TTableRowModel)
    case Font(UIFont)
    case Color(UIColor)
    case Error(Error)
    case Array(Array<TAny>)
    case Dictionary([String: TAny])
    case ViewController(UIViewController)
    case Empty
    
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
    
    
    public func array() -> Array<TAny> {
        if case let TAny.Array(value) = self {
            return value
        }
        else {
            return [TAny.Empty]
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
