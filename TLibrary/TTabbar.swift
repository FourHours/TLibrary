//
//  TTabbar.swift
//  TLibrary
//
//  Created by Q Zhuang on 5/13/17.
//  Copyright © 2017 Q Zhuang. All rights reserved.
//

import Foundation

public extension TTabBar {
    public enum PropertyName {
        public static let icons = "icons"
        public static let selectedIcons = "selectedIcons"
        public static let parentViewController = "parentViewController"
        public static let viewControllers = "viewControllers"

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


public final class TTabBar: TEventEmitter, TMethodChain {
    var bindingTabBar: AZTabBarController!
    var parentViewController: UIViewController!
    var nomarlIcons: [String]!
    var highlightedIcons: [String]!
    var viewControllers: [UIViewController]!
    
    public init() {
        
    }
    
    public func validate() {
        
        //1.
        if let vc = properties[TTabBar.PropertyName.parentViewController] {
            parentViewController = vc.viewController()
        }
        assert(parentViewController != nil)
        
        //2.
        if let nIcons = properties[TTabBar.PropertyName.icons] {
            nomarlIcons =  nIcons.array().map({ $0.asTAnyObject().string() })
        }
        
        if let hIcons = properties[TTabBar.PropertyName.selectedIcons] {
            highlightedIcons =  hIcons.array().map({ $0.asTAnyObject().string() })
        }
        assert(nomarlIcons.count > 0 && nomarlIcons.count == highlightedIcons.count)

        //3.
        
        if let vcs = properties[TTabBar.PropertyName.viewControllers] {
            viewControllers = vcs.array().map({ $0.asTAnyObject().viewController() })
        }
        assert(nomarlIcons.count == viewControllers.count)
        
    }

    
    public func end() {
        validate()
        
        bindingTabBar = AZTabBarController.insert(into: parentViewController, withTabIconNames: nomarlIcons, andSelectedIconNames: highlightedIcons)
        
        bindingTabBar.delegate = self
        
        (0 ..< viewControllers.count).forEach({index in
            bindingTabBar.setViewController(viewControllers[index], atIndex: index)
        })
        
        // default
        bindingTabBar.selectionIndicatorColor = #colorLiteral(red: 0.1803921569, green: 0.8, blue: 0.4431372549, alpha: 1)
        bindingTabBar.animateTabChange = true
        bindingTabBar.buttonsBackgroundColor = UIColor(colorLiteralRed: (247.0/255), green: (247.0/255), blue: (247.0/255), alpha: 1.0)//#colorLiteral(red: 0.2039215686, green: 0.2862745098, blue: 0.368627451, alpha: 1)
    }

}


extension TTabBar: AZTabBarDelegate{
    public func tabBar(_ tabBar: AZTabBarController, statusBarStyleForIndex index: Int) -> UIStatusBarStyle {
        return (index % 2) == 0 ? .default : .lightContent
    }
    
    public func tabBar(_ tabBar: AZTabBarController, shouldLongClickForIndex index: Int) -> Bool {
        return false//index != 2 && index != 3
    }
    
    public func tabBar(_ tabBar: AZTabBarController, shouldAnimateButtonInteractionAtIndex index: Int) -> Bool {
        return !(index == 3 || index == 2)
    }
    
    public func tabBar(_ tabBar: AZTabBarController, didMoveToTabAtIndex index: Int) {
//        print("didMoveToTabAtIndex \(index)")
    }
    
    public func tabBar(_ tabBar: AZTabBarController, didSelectTabAtIndex index: Int) {
        print("didSelectTabAtIndex \(index)")
    }
    
    public func tabBar(_ tabBar: AZTabBarController, willMoveToTabAtIndex index: Int) {
//        print("willMoveToTabAtIndex \(index)")
    }
    
    public func tabBar(_ tabBar: AZTabBarController, didLongClickTabAtIndex index: Int) {
//        print("didLongClickTabAtIndex \(index)")
    }
    
    
    
}
