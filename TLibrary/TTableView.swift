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
        
    }
    
    public enum EventName {
        public static let onSelection = "onSelection"

    }
    public enum TableCellType {
        case Value1
        case Nib
        case Dynamic
    }
}

public typealias TSection = TTableDataSource.TableSection
public typealias TTableRowModel = Mappable

public final class TUITableView: UITableView, TEventEmitter, TMethodChain {

    public func end() {
        self.dataSource = self
        self.delegate = self
        
        let cellType = properties[UITableView.PropertyName.cellType] as! UITableView.TableCellType
        
        switch cellType {
        case .Value1:
            self.register(UITableViewCell.self, forCellReuseIdentifier: cellItentifier())
        case .Nib:
            let name = properties[UITableView.PropertyName.cellClassName] as! String
            self.register(UINib(nibName: name, bundle: nil), forCellReuseIdentifier: name)
        default: break
        }
        
    }

    func getDataSource() -> TTableDataSource? {
        let ds = properties[UITableView.PropertyName.dataSource] as! TTableDataSource
        return ds
    }

}

extension TUITableView: UITableViewDataSource {
    public func numberOfSections(in _: UITableView) -> Int {
        return (getDataSource()?.numberOfSections())!
    }

    public func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let ds = getDataSource()
            else { return 0 }
        
        if ds.sections.count > 0 {
            return (ds[section].rows?.count)!
        }
        else {
            return 0
        }

    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cellType = properties[UITableView.PropertyName.cellType] as! UITableView.TableCellType
        switch cellType {
        case .Value1:
            let tableCell = TBasicTableCell(style: UITableViewCellStyle.value1, reuseIdentifier: cellItentifier())
            tableCell.configure(row: (getDataSource()?[indexPath])!)
            return tableCell

        case .Nib, .Dynamic:
            let name = properties[UITableView.PropertyName.cellClassName] as! String

            let cell = tableView.dequeueReusableCell(withIdentifier: name, for: indexPath) as! TTableCellDatasource
            cell.configure(row: (getDataSource()?[indexPath])!)
            return cell as! UITableViewCell
        }
    }


    public func cellItentifier() -> String {
        return String(describing: type(of: self))
    }
}

extension TUITableView: UITableViewDelegate {
    public func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ds = properties[UITableView.PropertyName.dataSource] as! TTableDataSource
        emit(UITableView.EventName.onSelection, data: ds[indexPath] )
    }
}

