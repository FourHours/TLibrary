//
//  TEventEmitter.swift
//  TLibrary
//
//  Created by Q Zhuang on 5/12/17.
//  Copyright © 2017 Q Zhuang. All rights reserved.
//

/*
    Node.js EventEmitter in Swift
 */

import Foundation

public typealias TEventEmitterCallback = (Any) -> Void


public protocol TEventEmitter: class {
    func on(_ event: String, handler: @escaping TEventEmitterCallback) -> Self
    func emit(_ event: String, data: Any)
} 

private struct AssociatedKey {
    static var events = "events"
}

public extension TEventEmitter {

    var events: [String: [TEventEmitterCallback]] { // cat is *effectively* a stored property
        get {
            return AssociatedObject.get(base: self, key: &AssociatedKey.events)
            { return [String: [TEventEmitterCallback]]() } // Set the initial value of the var
        }
        set { AssociatedObject.set(base: self,key: &AssociatedKey.events, value: newValue) }
    }
    
    public func on(_ event: String, handler: @escaping TEventEmitterCallback) -> Self {
        if var handlers = events[event] {
            handlers.append(handler)
        }
        else {
            events[event] = [handler]
        }
        
        return self
    }
    
    public func emit(_ event: String, data: Any) {
        if let handlers = events[event] {
            handlers.forEach{$0(data)}
        }
    }
}


/*
 
 class Dog: TEventEmitter {
 func bark() {
 emit(event: "bark", data: [1,4])
 }
 }
 
 
 var dog = Dog()
 dog.on(event: "bark") { (data) in
 print(data)
 }
 
 dog.bark()
 */
