//
// Created by Q Zhuang on 5/14/17.
// Copyright (c) 2017 Q Zhuang. All rights reserved.
//

import Foundation
import RealmSwift

open class TBasicRealmModel: Object {
    public dynamic var idKey = 0
    public dynamic var content : String = ""


    open override static func primaryKey() -> String? {
        return "idKey"
    }

}
