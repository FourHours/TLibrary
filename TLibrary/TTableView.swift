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

public typealias TTableRowModel = Mappable

public struct TSectionModel {
    public init(title: String, rows: [TTableRowModel]) {
        self.title = title
        self.rows = rows
    }
    
    var title: String
    var rows: [TTableRowModel]
    
    public func numberOfRows() -> Int {
        return rows.count
    }
}

public struct TTableModel {

    var sections = [TSectionModel]()

    public init() {}

    public init(sections: [TSectionModel]) {
        self.sections = sections
    }

    public func numberOfSections() -> Int {
        return sections.count
    }

    public subscript(indexPath: IndexPath) -> TTableRowModel {
        assert(indexPath.section < sections.count
            && indexPath.row < sections[indexPath.section].numberOfRows(), "Index out of range")
        return sections[indexPath.section].rows[indexPath.row]
    }
    
    public subscript(section: Int, row: Int) -> TTableRowModel {
        assert(section < sections.count
            && row < sections[section].numberOfRows(), "Index out of range")
        return sections[section].rows[row]
    }

    public subscript(section: Int) -> TSectionModel {
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

public final class TUITableView: UITableView, TEventEmitter, TMethodChain {
    var tableModel = TTableModel()
    
    public func validate() {
        //1. datasource
        if let dsData = properties[TUITableView.PropertyName.dataSource] {
            tableModel = dsData.tableModel()
        }
        else {
            tableModel = TTableModel()
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
        var cellType = UITableView.TableCellType.Value1
        if let type = properties[UITableView.PropertyName.cellType] {
            cellType = UITableView.TableCellType(rawValue: type.int())!

        }
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
        return tableModel[section].numberOfRows()
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
        emit(UITableView.EventName.onSelection, data: TAny.TableRowModel(tableModel[indexPath]))
    }
}

