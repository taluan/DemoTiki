//
//  APIClient.swift
//  TikiDemo
//
//  Created by Luan Tran on 12/19/18.
//  Copyright © 2018 Luan Tran. All rights reserved.
//

import UIKit
import Alamofire

class APIClient {

    public static let Shared = APIClient()
    public typealias keywordsCompletionBlock = (_ keywords: [KeywordModel], _ error: Error?) -> ()
    
    public func getHotKeywords(completionBlock:@escaping keywordsCompletionBlock) {
        Alamofire.request(Router.GetHotKeyword()).responseCollection { (response: DataResponse<[KeywordModel]>) in
            switch response.result {
            case .success(let datas):
                completionBlock(datas, nil)
            case .failure(let error):
                completionBlock([], error)
            }
        }
    }
}
