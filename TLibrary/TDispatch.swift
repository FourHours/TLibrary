//
// Created by Q Zhuang on 5/14/17.
// Copyright (c) 2017 Q Zhuang. All rights reserved.
//

import Foundation

public final class TDispatch: TEventEmitter {
    public static let sharedInstance = TDispatch()
    let hardWorker = DispatchQueue(label: "construction_worker_0", qos: .userInteractive) // higher importance

    private init() {
    } //This prevents others from using the default '()' initializer for this class.

    public func async(task: @escaping ()-> Void ) {
        hardWorker.async {
            task()
        }
    }
    
    public func asyncOnMainQueue(task: @escaping ()-> Void ) {
        DispatchQueue.main.async {
            task()

        }
    }
    

}
