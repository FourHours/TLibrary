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
    public static let almostBlack = UIColor(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1)
    // 204, 76, 86

    public static let lightSkyBlue = UIColor(hue: 204/360.0, saturation: 76/100.0, brightness: 86/100.0, alpha: 1)
    
    public static let tableGroupBackground = UIColor(red: 239.0/255.0, green: 239.0/255.0, blue: 244.0/255, alpha: 1)
    
}

public enum TFont {
    public static let headline = UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
    public static let subhead = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
    public static let body = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
}
