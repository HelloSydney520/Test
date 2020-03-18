//
//  Http.swift
//  Test
//
//  Created by Evan Su on 18/3/20.
//  Copyright © 2020 techtask. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension Int {
    var httpStatusCodeDescription: String {
        return HTTPURLResponse.localizedString(forStatusCode: self)
    }
}

extension Reactive where Base: URLSession {
    public func responseData(request: URLRequest) -> Observable<Data> {
        return response(request: request).map { pair -> Data in
            let statusCode = pair.0.statusCode
            switch statusCode {
            case 200 ..< 300:
                return pair.1
            default:
                let errorMessage = String(data: pair.1, encoding: .utf8) ?? ""
                throw NSError(domain: "com.techtask.Test", code: statusCode, userInfo: ["message": errorMessage])
            }
        }
    }
    
    public func jsonData(request: URLRequest, options: JSONSerialization.ReadingOptions = []) -> Observable<Any> {
        return responseData(request: request).map { (data) -> Any in
            do {
                return try JSONSerialization.jsonObject(with: data, options: options)
            } catch let error {
                throw RxCocoaURLError.deserializationError(error: error)
            }
        }
    }
    
    public func textData(request: URLRequest) -> Observable<(Int,String)> {
        return response(request: request).map { pair -> (Int,String) in
            let statusCode = pair.0.statusCode
            let responseText = String(data: pair.1, encoding: .utf8) ?? ""
            switch statusCode {
            case 200 ..< 300:
                return (statusCode, responseText)
            default:
                throw NSError(domain: "com.techtask.Test", code: statusCode, userInfo: ["message": responseText])
            }
        }
    }
}

