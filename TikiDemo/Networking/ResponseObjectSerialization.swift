//
//  ResponseObjectSerialization.swift
//  TikiDemo
//
//  Created by Luan Tran on 12/19/18.
//  Copyright © 2018 Luan Tran. All rights reserved.
//

import Foundation
import Alamofire

public protocol ResponseObjectSerializable {
    init?(response: HTTPURLResponse, representation: Any)
}

public extension DataRequest {
    @discardableResult
    func responseObject<T: ResponseObjectSerializable>(completionHandler: @escaping (DataResponse<T>) -> Void)
        -> Self
    {
        let responseSerializer = DataResponseSerializer<T> { request, response, data, error in
            guard error == nil else { return .failure(error!) }
            
            let jsonResponseSerializer = DataRequest.jsonResponseSerializer(options: .allowFragments)
            let result = jsonResponseSerializer.serializeResponse(request, response, data, nil)
            switch result {
            case .success(let value):
                print("value: \(value)")
                if let response = response {
                    if response.statusCode != 200 {
                        let error = BaseResponseError.errorWithCode(code: response.statusCode, failureReason: "Server Error")
                        return .failure(error)
                    }
                }
                guard let response = response, let responseObject = T(response: response, representation: value) else {
                    let failureReason = "JSON could not be serialized into response object: \(value)"
                    let error = BaseResponseError.errorWithCode(code: BaseResponseError.TikiErrorCode.JSONSerializationFailed.rawValue, failureReason: failureReason)
                    return .failure(error)
                }
                
                return .success(responseObject)
            case .failure(let error):
                print("error: \(error)")
                return .failure(result.error!)
            }
            
            
        }
        
        return response(queue: nil, responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
    
    @discardableResult
    public func responseCollection<T: ResponseCollectionSerializable>(completionHandler: @escaping (DataResponse<[T]>) -> Void) -> Self {
        let responseSerializer = DataResponseSerializer<[T]> { request, response, data, error in
            guard error == nil else { return .failure(error!) }
            
            let jsonResponseSerializer = DataRequest.jsonResponseSerializer(options: .allowFragments)
            let result = jsonResponseSerializer.serializeResponse(request, response, data, nil)
            
            switch result {
            case .success(let value):
                guard let response = response else {
                    let failureReason = "JSON could not be serialized into response collection object: \(value)"
                    let error = BaseResponseError.errorWithCode(code: BaseResponseError.TikiErrorCode.JSONSerializationFailed.rawValue, failureReason: failureReason)
                    return .failure(error)
                }
                let responseObject:[T] = T.collection(response: response, representation: value)
                return .success(responseObject)
            case .failure(let error):
                print("error: \(error)")
                return .failure(error)
            }
        }
        
        return response(queue: nil, responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
}

public protocol ResponseCollectionSerializable {
    static func collection(response: HTTPURLResponse, representation: Any) -> [Self]
}

public extension ResponseCollectionSerializable where Self: ResponseObjectSerializable {
    static func collection(response: HTTPURLResponse, representation: Any) -> [Self] {
        var collection: [Self] = []
        
        if let representation = representation as? [[String: Any]] {
            for itemRepresentation in representation {
                if let item = Self(response: response, representation: itemRepresentation) {
                    collection.append(item)
                }
            }
        }
        
        return collection
    }
}
