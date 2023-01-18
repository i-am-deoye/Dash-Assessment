//
//  Response.swift
//  Dash_Assessment
//
//  Created by ADMIN on 1/18/23.
//

import Foundation

extension Int {
    var isStatusCodeUnAuthorized : Bool {
        return self == 401
    }
    
    var isError : Bool {
        return Array.init(400...500).contains(self)
    }
    
    var success : Bool {
        return 200 == self
    }
}

struct Response<R:Responseable> : Responseable {
    let data: R
}


public struct VoidData : Responseable, Requestable {
    var message: String = ""
    init() {}
}
