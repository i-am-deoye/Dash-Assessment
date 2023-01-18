//
//  Query.swift
//  Dash_Assessment
//
//  Created by ADMIN on 1/18/23.
//

import Foundation


public class Query {
    
    private var _query:String = ""
    
    public init(){}
    
    public convenience init(query: String = ""){
        self.init()
        self._query = query
    }
    
    open func toString() -> String{
        return _query
    }
    
    private func formatValue(_ value: Any) -> String {
        return "\((value is String) ?  "'\(value)'" : "\(value)")"
    }
 
    
    open func equal(key:String, value:Any) -> Query{
        _query = _query + "\(key) == \(formatValue(value))"
        return self
    }
}
