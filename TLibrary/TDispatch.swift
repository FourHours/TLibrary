//
// Created by Q Zhuang on 5/14/17.
// Copyright (c) 2017 Q Zhuang. All rights reserved.
//

import Foundation

public final class TDispatch: TEventEmitter {
    public static let sharedInstance = TDispatch()
    let hardWorker = DispatchQueue(label: "construction_worker_0", qos: .userInitiated) // higher importance

    private init() {
    } //This prevents others from using the default '()' initializer for this class.

    public func async(task: @escaping ()-> Void ) {
        hardWorker.async {
            task()
        }
    }

}
