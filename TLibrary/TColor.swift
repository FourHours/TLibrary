//
//  TColor.swift
//  AwesomePosts
//
//  Created by Q Zhuang on 5/9/17.
//  Copyright © 2017 Q Zhuang. All rights reserved.
//

import Foundation
import UIKit

public enum TColor {
    // #333333 RGB (51,51,51)
    public static let almostBlack = UIColor.init(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1)
}

public enum TFont {
    public static let headline = UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
    public static let subhead = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
    public static let body = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
}
