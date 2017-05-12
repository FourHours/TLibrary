//
//  THttpBuilder.swift
//  AwesomePosts
//
//  Created by Q Zhuang on 5/7/17.
//  Copyright © 2017 Q Zhuang. All rights reserved.
//

import Foundation
import ObjectMapper

public enum TBackendError: Error {
    case network(error: Error) // Capture any underlying Error from the URLSession API
    case dataSerialization(error: Error)
    case jsonSerialization(error: Error)
    case xmlSerialization(error: Error)
    case objectSerialization(reason: String)
}

public class THttpConnection {
    enum method {
        case get
        case post
    }

    var url: String!
    var dataResponseHandler: ((Data) -> Void)?
    var stringResponseHandler: ((String) -> Void)?
    var errorHandler: ((Error) -> Void)?
    var debugging = false

    public init() {
    }

    public init(URL: String) {
        url = URL
    }

    public func url(_ URL: String) -> Self {
        url = URL
        return self
    }

    public func debug(_ debug: Bool) -> Self {
        debugging = debug
        return self
    }

    public func onDataResponseHandler(_ handler: @escaping (Data) -> Void) -> Self {
        dataResponseHandler = handler
        return self
    }

    public func onStringResponseHandler(_ handler: @escaping (String) -> Void) -> Self {
        stringResponseHandler = handler
        return self
    }

    public func onErrorHandler(_ handler: @escaping (Error) -> Void) -> Self {
        errorHandler = handler
        return self
    }

    public func start() {
        /*
         public init?(string: String, relativeTo url: URL?)

         */
        let request = URLRequest(url: URL(string: url)!)

        let dataTask = URLSession.shared.dataTask(with: request) { data, _, error in
            if let data = data,
                let jsonString = String(data: data, encoding: String.Encoding.utf8) {

                if self.debugging {
                    print("json = \(jsonString)")
                }

                if let handler = self.dataResponseHandler {
                    handler(data)
                }

                if let handler = self.stringResponseHandler {
                    handler(jsonString)
                }
            } else if let error = error {
                self.errorHandler?(error)
            } else {
                let error = NSError(domain: "THttpResource", code: 0,
                                    userInfo: [NSLocalizedDescriptionKey: "Unknown error"])
                self.errorHandler?(error)
            }
        }
        dataTask.resume()
    }
}
