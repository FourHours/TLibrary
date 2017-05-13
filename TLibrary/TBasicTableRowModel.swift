//
//  Person.swift
//  AwesomePosts
//
//  Created by Q Zhuang on 5/6/17.
//  Copyright © 2017 Q Zhuang. All rights reserved.
//
import ObjectMapper

public class TBasicTableRowModel: Mappable {
    var title: String?
    var detailText: String?

    public required init?(map _: Map) {
    }

    public init(title: String, detailText: String) {
        self.title = title
        self.detailText = detailText
    }

    public func mapping(map: Map) {
        title <- map["title"]
        detailText <- map["detailText"]
    }
}
