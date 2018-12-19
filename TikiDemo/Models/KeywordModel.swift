//
//  KeywordModel.swift
//  TikiDemo
//
//  Created by Luan Tran on 12/19/18.
//  Copyright © 2018 Luan Tran. All rights reserved.
//

import Foundation

struct KeywordModel: ResponseCollectionSerializable {
    
    public let keyword: String
    public let icon: String
    
    public init?(response: HTTPURLResponse, representation: Any) {
        guard let representation = representation as? [String: Any] else { return nil }
        self.keyword = representation["keyword"] as! String
        self.icon = representation["icon"] as! String
    }
    
    static func collection(response: HTTPURLResponse, representation: Any) -> [KeywordModel] {
        var collection: [KeywordModel] = []
        if let representation = representation as? [String: Any] {
            if let data = representation["keywords"] as? [[String: Any]] {
                for itemRepresentation in data {
                    if let item = KeywordModel(response: response, representation: itemRepresentation) {
                        collection.append(item)
                    }
                }
            }
        }
        return collection
    }
}
