//
//  TButton.swift
//  TLibrary
//
//  Created by Q Zhuang on 5/9/17.
//  Copyright © 2017 Q Zhuang. All rights reserved.
//

import Foundation

//public class ClosureSleeve {
//    let closure: () -> Void
//
//    init(_ closure: @escaping () -> Void) {
//        self.closure = closure
//    }
//
//    @objc func invoke() {
//        closure()
//    }
//}
//
//public extension UIControl {
//    public func add(for controlEvents: UIControlEvents, _ closure: @escaping () -> Void) {
//        let sleeve = ClosureSleeve(closure)
//        addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
//        objc_setAssociatedObject(self, String(format: "[%d]", arc4random()), sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
//    }
//}

public extension UIButton {
    public enum PropertyName {
        public static let backgroundColor = "backgroundColor"

    }
    public enum EventName {
        public static let onClick = "onClick"
        
    }
}

public final class TUIButton: UIButton, TMethodChain, TEventEmitter {
    public func validate() {
        
    }

    
    public override func end() {
        addTarget(self, action: #selector(self.onClick), for: UIControlEvents.touchUpInside)
    }
    
    public func onClick(sender: UIButton) {
        emit(UIButton.EventName.onClick, data: TAny.Empty)
    }
}



/*
 button.add(for: .touchUpInside) {
 print("Hello, Closure!")
 }
 */
