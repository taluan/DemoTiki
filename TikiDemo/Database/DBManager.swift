//
//  DBManager.swift
//  TikiDemo
//
//  Created by Luan Tran on 12/19/18.
//  Copyright © 2018 Luan Tran. All rights reserved.
//

import UIKit
import RealmSwift

class DBManager: NSObject {

    private var database:Realm
    static let Shared = DBManager()
    
    private override init() {
        database = try! Realm()
    }
    
    func getHistoryKeywords() -> [KeywordObject] {
        let results: Results<KeywordObject> = database.objects(KeywordObject.self)
        return Array(results.sorted(byKeyPath: "search_date", ascending: false))
    }
    
    func addKeyword(keyword: KeywordObject) {
        try! database.write {
            database.add(keyword, update: true)
            print("Added new keyword")
        }
    }
    
    func clearAllHistory()  {
        try! database.write {
            database.deleteAll()
        }
    }
}
