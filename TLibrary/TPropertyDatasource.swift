//
//  TCoceInjectionable.swift
//  AwesomePosts
//
//  Created by Q Zhuang on 5/7/17.
//  Copyright © 2017 Q Zhuang. All rights reserved.
//

import Foundation
import UIKit

/*
 For view controller to accept passed property
 */

public protocol TPropertyDatasource: class {
    var props: Dictionary<String, Any>? { set get }
}
