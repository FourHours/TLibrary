//
//  TAnimation.swift
//  TLibrary
//
//  Created by Q Zhuang on 5/16/17.
//  Copyright © 2017 Q Zhuang. All rights reserved.
//

import Foundation


extension UIView {
    
    public class Animator {
        
        public typealias Completion = (Bool) -> Void
        public typealias Animations = () -> Void
        
        var animations: Animations
         var completion: Completion?
         let duration: TimeInterval
         let delay: TimeInterval
         let options: UIViewAnimationOptions
        
        public init(duration: TimeInterval, delay: TimeInterval = 0, options: UIViewAnimationOptions = []) {
            self.animations = {}
            self.completion = nil
            self.duration = duration
            self.delay = delay
            self.options = options
        }
        
        public func animations(_ animations: @escaping Animations) -> Self {
            self.animations = animations
            return self
        }
        
        public func completion(_ completion: @escaping Completion) -> Self {
            self.completion = completion
            return self
        }
        
        public func animate() {
            UIView.animate(withDuration: duration, delay: delay, animations: animations, completion: completion)
        }
    }
    
    public final class SpringAnimator: Animator {
        
        fileprivate let damping: CGFloat
        fileprivate let velocity: CGFloat
        
        public init(duration: TimeInterval, delay: TimeInterval = 0, damping: CGFloat, velocity: CGFloat, options: UIViewAnimationOptions = []) {
            self.damping = damping
            self.velocity = velocity
            
            super.init(duration: duration, delay: delay, options: options)
        }
        
        public override func animate() {
            UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: damping, initialSpringVelocity: velocity, options: options, animations: animations, completion: completion)
        }
    }
}




extension UIView {
    
    
    func shiftBy(_ size: CGSize) -> Self {
        
        
        return self
    }
    func shrinkrkBy() -> Self {
        return self
    }
    
    func rotatBy() -> Self {
        return self
    }
    func end() {}
}

/*
 1.
 UIView.Animator(duration: 0.3)
 .animations {
 view.frame.size.height = 100
 view.frame.size.width = 100
 }
 .completion { finished in
 view.backgroundColor = .black
 }
 .animate()
 
 2.
 UIView.SpringAnimator(duration: 0.3, delay: 0.2, damping: 0.2, velocity: 0.2, options: [.autoreverse, .curveEaseIn])
 .animations { }
 .completion { _ in }
 .animate()
 
 3.
 UIView.Animator(duration: 0.4, delay: 0.2, options: [.autoreverse, .curveEaseIn])
 .animations { }
 .completion { _ in }
 .animate()
 */
