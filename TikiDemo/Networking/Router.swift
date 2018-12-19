//
//  Router.swift
//  TikiDemo
//
//  Created by Luan Tran on 12/19/18.
//  Copyright © 2018 Luan Tran. All rights reserved.
//

import UIKit
import Alamofire

public enum Router: URLRequestConvertible {
    
    static let baseURLString = "https://tiki-mobile.s3-ap-southeast-1.amazonaws.com/ios"
    
    // =========== Begin define api ===========
    case GetHotKeyword()
    // =========== End define api ===========
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .GetHotKeyword:
            return .get
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .GetHotKeyword:
            return "keywords.json"
        
        }
    }
    
    // MARK: - Headers
    private var headers: HTTPHeaders {
        let headers = ["Accept": "application/json"]
        
        return headers;
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .GetHotKeyword():
            return nil
        }
    }
    
    // MARK: - URL request
    public func asURLRequest() throws -> URLRequest {
        let url = try Router.baseURLString.asURL()
        
        // setting path
        var urlRequest: URLRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // setting method
        urlRequest.httpMethod = method.rawValue
        
        // setting header
        for (key, value) in headers {
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }
        
        if let parameters = parameters {
            do {
                urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
            } catch {
                print("Encoding fail")
            }
        }
        
        return urlRequest
    }
}
