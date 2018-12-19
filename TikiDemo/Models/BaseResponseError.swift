//
//  BaseResponseError.swift
//  TikiDemo
//
//  Created by Luan Tran on 12/19/18.
//  Copyright © 2018 Luan Tran. All rights reserved.
//

import Foundation

class BaseResponseError: NSObject {

    public static let Domain = "tiki.vn"
    
    public enum TikiErrorCode: Int {
        case JSONSerializationFailed = 1
        case InvalidParams = 100
    }
    
    /**
     Creates an `NSError` with the given error code and failure reason.
     - parameter code:          The error code.
     - parameter failureReason: The failure reason.
     - returns: An `NSError` with the given error code and failure reason.
     */
    public static func errorWithCode(code: TikiErrorCode, failureReason: String) -> NSError {
        return errorWithCode(code: code.rawValue, failureReason: failureReason)
    }
    
    /**
     Creates an `NSError` with the given error code and failure reason.
     - parameter code:          The error code.
     - parameter failureReason: The failure reason.
     - returns: An `NSError` with the given error code and failure reason.
     */
    public static func errorWithCode(code: Int, failureReason: String) -> NSError {
        let userInfo = [NSLocalizedDescriptionKey: failureReason]
        return NSError(domain: Domain, code: code, userInfo: userInfo)
    }
}
