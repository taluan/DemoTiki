//
//  KeywordObject.swift
//  TikiDemo
//
//  Created by Luan Tran on 12/19/18.
//  Copyright © 2018 Luan Tran. All rights reserved.
//

import UIKit
import RealmSwift

class KeywordObject: Object {
    @objc dynamic var search_date = Date()
    @objc dynamic var keyword: String = ""
    
    override static func primaryKey() -> String? {
        return "keyword"
    }
    
    convenience init(keyword: String) {
        self.init()
        self.keyword = keyword
    }
}
