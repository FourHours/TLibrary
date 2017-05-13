//
//  TableCell.swift
//  AwesomePosts
//
//  Created by Q Zhuang on 5/6/17.
//  Copyright © 2017 Q Zhuang. All rights reserved.
//

import Foundation
import ObjectMapper

public protocol TTableCellDatasource: class {
    func configure(row: Mappable)
}

public class TBasicTableCell: UITableViewCell, TTableCellDatasource {
    public func configure(row: Mappable) {
        self.selectionStyle = .none
        
        if let rowData = row as? TBasicTableRowModel {
            textLabel?.text = rowData.title
            detailTextLabel?.text = rowData.detailText
        }
    }
}
