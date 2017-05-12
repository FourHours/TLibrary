//
//  Stack.swift
//  AwesomePosts
//
//  Created by Q Zhuang on 4/23/17.
//  Copyright © 2017 Q Zhuang. All rights reserved.
//

public struct TStack<T> {
    private lazy var container: [T] = {
        [T]()
    }()

    public mutating func push(_ element: T) {
        container.append(element)
    }

    public mutating func popup() -> T? {
        return container.popLast()
    }

    public mutating func top(_ number: Int) -> [T]? {
        // ArraySlice
        if number > container.count { return .none }
        return Array(container.suffix(number))
    }
}

public struct TQueue {
    public func enqueue(element _: Int) {
    }

    public func dequeue() -> Int {
        return 0
    }
}
