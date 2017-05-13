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
    public func validate() {
        
    }

    
    public func end() {
        for(key, value) in properties {
            switch key {
            case UILabel.PropertyName.textColor:
                self.textColor = value.color()
            case UILabel.PropertyName.text:
                self.text = value.string()
            case UILabel.PropertyName.font:
                self.font = value.font()
            default:
                break
            }
        }
    }
}
