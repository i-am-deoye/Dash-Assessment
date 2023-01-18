//
//  IDataBaseDriver.swift
//  Dash_Assessment
//
//  Created by ADMIN on 1/18/23.
//

import Foundation
import CoreData


struct FetchResult<T> {
    var items: [T]
    var error: String?
    var item: T? {
        return items.first
    }
    
    init(item: T? = nil, error: String?) {
        
        self.items = []
        if let value = item {
            self.items = [value]
        }
        self.error = error
    }
    
    init(items: [T] , error: String?) {
        self.items = items
        self.error = error
    }
}


struct SaveResult {
    let isSaved: Bool
    let error: String
    
    init(isSaved: Bool, error: String = "") {
        self.isSaved = isSaved
        self.error = error
    }
}

struct DeleteResult {
    let isDeleted: Bool
    let error: String?
    
    init(isDeleted: Bool, error: String?) {
        self.isDeleted = isDeleted
        self.error = error
    }
}

protocol IDataBaseDriver {
    
    @discardableResult func save<T>(_ entity: T) -> SaveResult
    @discardableResult func save<T>(_ entities: [T]) -> SaveResult
    @discardableResult func fetch<T>(_ type: T.Type, query: Query) -> FetchResult<T>
    @discardableResult func fetch<T>(_ type: T.Type) -> FetchResult<T>
    @discardableResult func delete<T>(_ entity: T) -> DeleteResult
}
