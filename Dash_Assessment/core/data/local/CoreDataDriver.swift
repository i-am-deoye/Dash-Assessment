//
//  CoreDataDriver.swift
//  Dash_Assessment
//
//  Created by ADMIN on 1/17/23.
//

import Foundation
import CoreData

final class CoreDataDriver: IDataBaseDriver {

    static let shared = CoreDataDriver()
    var context: NSManagedObjectContext!
    var psc : NSPersistentStoreCoordinator?
    
    
    private init() {
        self.initials()
    }
    
    
    private func initials() {
        guard let modelURL = Bundle.main.url(forResource: "Dash_Assessment", withExtension:"momd") else {
            fatalError("Error loading model from bundle")
        }
        
        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }
        
        psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        
        context = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
        context.persistentStoreCoordinator = psc
        
            guard let docURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
                fatalError("Unable to resolve document directory")
            }
            let storeURL = docURL.appendingPathComponent("Dash_Assessment.sqlite")
            do {
                try psc?.addPersistentStore(ofType: NSSQLiteStoreType,
                                           configurationName: nil,
                                           at: storeURL,
                                           options: [NSMigratePersistentStoresAutomaticallyOption:true, NSInferMappingModelAutomaticallyOption:true])
            } catch {
                fatalError("Error migrating store: \(error)")
            }
    }
    
    
    private func fetchRequest<T>(_ type: T.Type, query: String?) -> NSFetchRequest<NSFetchRequestResult> {
        let entityName = String(describing: type)
        let request = NSFetchRequest<NSFetchRequestResult>.init(entityName: entityName)
        if let query = query {
            request.predicate = NSPredicate.init(format: query)
        }
        return request
    }
    
    @discardableResult func save<T>(_ entity: T) -> SaveResult {
        guard let entity = entity as? NSManagedObject else { return SaveResult.init(isSaved: false, error: "inavlid entity type") }
        
        do {
            try entity.managedObjectContext?.save()
            return SaveResult.init(isSaved: true)
        } catch {
            return SaveResult.init(isSaved: false, error: error.localizedDescription)
        }
    }
    
    @discardableResult func save<T>(_ entities: [T]) -> SaveResult {
        var session = [T]()
        var isError = false
        for entity in entities {
            let result = self.save(entity)
            if !result.isSaved {
                isError = true
                break
            }
            
            session.append(entity)
        }
        
        if isError {
            self.deleteAll(session)
            return SaveResult.init(isSaved: false, error: "Transaction has been rolled back.")
        }
        
        return SaveResult.init(isSaved: true)
    }
    
    
    @discardableResult func fetch<T>(_ type: T.Type, query: Query) -> FetchResult<T> {
        return self._fetch(type, query: query.toString())
    }
    
    @discardableResult func fetch<T>(_ type: T.Type) -> FetchResult<T> {
        return self._fetch(type)
    }
    
    
    @discardableResult func delete<T>(_ entity: T) -> DeleteResult {
        guard let entity = entity as? NSManagedObject else { return DeleteResult.init(isDeleted: false, error: "inavlid entity type") }
        entity.managedObjectContext?.delete(entity)
        return DeleteResult.init(isDeleted: false, error: nil)
    }
    
    @discardableResult func deleteAll<T>(_ entities: [T]) -> DeleteResult {
        for entity in entities {
            self.delete(entity)
        }
        return DeleteResult.init(isDeleted: false, error: nil)
    }
    
}

fileprivate extension CoreDataDriver {
    func _fetch<T>(_ type: T.Type, query: String? = nil ) -> FetchResult<T> {
        do {
            let fetchRequest = self.fetchRequest(type, query: query)
            let items = try self.context.fetch(fetchRequest) as? [T] ?? []
            return FetchResult.init(items: items, error: nil)
        } catch {
            return FetchResult.init(items: [], error: error.localizedDescription)
        }
    }
}

