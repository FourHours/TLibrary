//
//  TBundleFile.swift
//  AwesomePosts
//
//  Created by Q Zhuang on 5/6/17.
//  Copyright © 2017 Q Zhuang. All rights reserved.
//

import Foundation

public class TBundleFile {
    public enum DataType {
        case array
        case dictionary
    }

    var fileName: String
    var ext: String
    var type = DataType.dictionary

    var onSuccessDictionayHandler: (([String: AnyObject]) -> Void)!
    var onSuccessArrayHandler: (([Any]) -> Void)!

    public init(fileName: String, ext: String) {
        self.fileName = fileName
        self.ext = ext
    }

    public func dataType(_ type: DataType) -> Self {
        self.type = type
        return self
    }

    public func onSuccessDictionayHandler(_ handler: @escaping ([String: AnyObject]) -> Void) -> Self {
        onSuccessDictionayHandler = handler
        return self
    }

    public func onSuccessArrayHandler(_ handler: @escaping ([Any]) -> Void) -> Self {
        onSuccessArrayHandler = handler
        return self
    }

    public func onFailure() -> TBundleFile {
        return self
    }

    public func start() {
        guard let path = Bundle.main.path(forResource: fileName, ofType: ext)
        else {
            fatalError("init(coder:) has not been implemented")
        }

        switch type {
        case .dictionary:
            if let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] {
                onSuccessDictionayHandler(dict)
            }
        case .array:
            if let array = NSArray(contentsOfFile: path) as? [Any] {
                onSuccessArrayHandler(array)
            }
        }
    }
}

func test() {
    TBundleFile(fileName: "product", ext: "pist")
        .dataType(.dictionary)
        .onSuccessDictionayHandler { dic in
            print(dic)
        }
        .onSuccessArrayHandler({ array in
            print(array)
        })
        .onFailure()
        .start()
}
