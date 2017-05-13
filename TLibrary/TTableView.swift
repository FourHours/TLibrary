//
//  TableViewBuilder.swift
//  AwesomePosts
//
//  Created by Q Zhuang on 5/6/17.
//  Copyright © 2017 Q Zhuang. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

public struct TTableDataSource {
    public struct TableSection {
        public init(title: String, rows: [Mappable]) {
            self.title = title
            self.rows = rows
        }

        var title: String?
        var rows: [Mappable]?
    }

    public struct TableRow {
    }

    var sections = [TableSection]()

    public init() {}

    public init(sections: [TableSection]) {
        self.sections = sections
    }

    public mutating func insertSection(_ section: TableSection) {
        sections.append(section)
    }

    public func numberOfSections() -> Int {
        return sections.count
    }

    public subscript(indexPath: IndexPath) -> Mappable {
        return (sections[indexPath.section].rows?[indexPath.row])!
    }

    public subscript(section: Int) -> TableSection {
        assert(section < sections.count, "Index out of range")
        return sections[section]
    }
}


public extension UITableView {
    public enum PropertyName {
        public static let dataSource = "dataSource"
        public static let debug = "debug"
        public static let cellType = "cellType"
        public static let cellClassName = "cellClassName"
        public static let cellSeparatorStyle = "cellSeparatorStyle"
        public static let cellSpacingHeight = "cellSpacingHeight"
        public static let cellSelectionStyle = "cellSelectionStyle"
    }
    
    public enum EventName {
        public static let onSelection = "onSelection"

    }
    public enum TableCellType: Int {
        case Value1 = 1
        case Nib
        case Dynamic
    }
}

public typealias TSection = TTableDataSource.TableSection
public typealias TTableRowModel = Mappable


private struct AssociatedKey {
    static var datasource = "datasource"
    static var validated = "validated"

}

public final class TUITableView: UITableView, TEventEmitter, TMethodChain {
    var tableModel: TTableDataSource { // cat is *effectively* a stored property
        get {
            return AssociatedObject.get(base: self, key: &AssociatedKey.datasource)
            { return TTableDataSource() } // Set the initial value of the var
        }
        set { AssociatedObject.set(base: self, key: &AssociatedKey.datasource, value: newValue) }
    }
    
    
    public func validate() {
        //1. datasource
        if let dsData = properties[TUITableView.PropertyName.dataSource] {
            tableModel = dsData.tableDataSource()
        }
        else {
            tableModel = TTableDataSource()
        }
        
        //2. cellClassName
        assert(properties[UITableView.PropertyName.cellClassName] != nil, "please config cellClassName first")
        
        //3. cellType
        assert(properties[UITableView.PropertyName.cellType] != nil, "please config cellType first")

    }
    
    public func end() {
        
        validate() //"Please call validate methoid first")
        
        self.dataSource = self
        self.delegate = self
        
        // Validated
        let cellType = UITableView.TableCellType(rawValue: (properties[UITableView.PropertyName.cellType]!.int()))!
        let cellItentifierName = properties[UITableView.PropertyName.cellClassName]!.string()

        switch cellType {
        case .Value1:
            self.register(UITableViewCell.self, forCellReuseIdentifier: cellItentifierName)
        case .Nib:
            if let name = properties[UITableView.PropertyName.cellClassName]?.string() {
                self.register(UINib(nibName: name, bundle: nil), forCellReuseIdentifier: name)

            }
            
        default: break
        }
        
    }
}

extension TUITableView: UITableViewDataSource {
    public func numberOfSections(in _: UITableView) -> Int {
        return tableModel.numberOfSections()
    }

    public func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {

        if tableModel.sections.count > 0 {
            return (tableModel[section].rows?.count)!
        }
        else {
            return 0
        }
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Validated
        let cellType = UITableView.TableCellType(rawValue: (properties[UITableView.PropertyName.cellType]!.int()))!
        let cellItentifierName = properties[UITableView.PropertyName.cellClassName]!.string()

        
        switch cellType {
        case .Value1:
            let tableCell = TBasicTableCell(style: UITableViewCellStyle.value1, reuseIdentifier: cellItentifierName)
            tableCell.configure(row: tableModel[indexPath])
            return tableCell

        case .Nib, .Dynamic:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellItentifierName, for: indexPath) as! TTableCellDatasource
            
            cell.configure(row: tableModel[indexPath])
            return cell as! UITableViewCell
        }
    }
}

extension TUITableView: UITableViewDelegate {
    public func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Validated
        emit(UITableView.EventName.onSelection, data: tableModel[indexPath] )
    }
}

