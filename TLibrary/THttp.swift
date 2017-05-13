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
    case noError
}

public extension THttp {
    public enum PropertyName {
        public static let url = "url"
        public static let baseUrl = "baseUrl"
        public static let method = "method"
        public static let contentType = "contentType"


    }
    
    public enum EventName {
        public static let onSuccess = "onSuccess"
        public static let onFailure = "onFailure"

        
    }
    
    enum method: Int {
        case get = 1
        case post
    }
    
    enum contentType: Int {
        case html = 1
        case string
        case json
        case data
        
    }
}

final public class THttp: TEventEmitter, TMethodChain {
    var url = ""
    var resonseType = THttp.contentType.html
    
    public init() {
    }

    public init(URL: String) {
    }
    
    public func validate() {
        //1. url
        if let urlData = properties[THttp.PropertyName.url] {
            url = urlData.string()
        }
        assert(url.characters.count > 0, "url is empty")
        
        //2. contentType
        if let contentTypeData = properties[THttp.PropertyName.contentType] {
            resonseType = THttp.contentType(rawValue: contentTypeData.int())!
        }
    }

    public func end() {
        validate()
        
        let request = URLRequest(url: URL(string: url)!)

        let dataTask = URLSession.shared.dataTask(with: request) { data, _, error in
            if let data = data,
                let html = String(data: data, encoding: String.Encoding.utf8) {
                
                switch self.resonseType {
                case THttp.contentType.html:
                    self.emit(THttp.EventName.onSuccess, data: TAny.String(html))
                case THttp.contentType.json:
                    self.emit(THttp.EventName.onSuccess, data: TAny.String(html))
                default: break
                }
   
            } else if let error = error {
                self.emit(THttp.EventName.onFailure, data: TAny.Error(error))
            }
        }
        dataTask.resume()
    }
}
