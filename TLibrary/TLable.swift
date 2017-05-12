//
//  TUILable.swift
//  AwesomePosts
//
//  Created by Q Zhuang on 5/7/17.
//  Copyright © 2017 Q Zhuang. All rights reserved.
//

import Foundation

public extension UILabel {
    public enum PropertyName {
        public static let textColor = "textColor"
        public static let textAlignment = "textAlignment"
        public static let text = "text"
        public static let font = "font"

        
//        public static let textColor = "textColor"

    }
}

public final class TUILabel: UILabel, TMethodChain {
    public func end() {
        for(key, value) in properties {
            self.setValue(value, forKey: key)
        }
    }
}
