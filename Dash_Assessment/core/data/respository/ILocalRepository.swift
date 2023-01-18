//
//  ILocalRepository.swift
//  Dash_Assessment
//
//  Created by ADMIN on 1/18/23.
//

import Foundation
import CoreData


protocol ILocalRepository {
    var local: IDataBaseDriver { get }
}


extension ILocalRepository {
    
    func save<T: NSManagedObject>(_ entities: [T]) {
        local.save(entities)
    }
}
