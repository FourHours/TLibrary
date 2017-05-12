//
//  TCustomTableViewCell.swift
//  AwesomePosts
//
//  Created by Q Zhuang on 5/6/17.
//  Copyright © 2017 Q Zhuang. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

/*
 This is an example to implement custom table cell
 */

public class TCustomTableViewCell: UITableViewCell, TTableCellDatasource {

    @IBOutlet weak var headline: UILabel!

    public static func identifier() -> String {
        return String(describing: type(of: self))
    }

    public func configure(row: Mappable) {
        if let person = row as? TBasicTableRowModel {
            headline?.text = person.title
        }
    }
}
