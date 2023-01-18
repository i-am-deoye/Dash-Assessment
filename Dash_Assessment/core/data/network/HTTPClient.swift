//
//  HTTPClient.swift
//  Dash_Assessment
//
//  Created by ADMIN on 1/18/23.
//

import Foundation



protocol HTTPClient {
    typealias Output =  (Data, HTTPURLResponse)
    typealias Result = Swift.Result<Output, Error>
    typealias HTTPHeaders = Dictionary<String, String>
    typealias CompletionResult = (Result) -> Void
    
    var headers: HTTPHeaders { get set }
    
    
    func get(from url: URL, completion:@escaping CompletionResult)
}


extension HTTPClient {
    func setDefaultHeaders(_ request:inout URLRequest) {
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
    }
}
