//
//  LMedia.swift
//  Dash_Assessment
//
//  Created by ADMIN on 1/18/23.
//

import Foundation
import CoreData

@objc(LMedia)
public class LMedia: NSManagedObject {
    convenience init() {
        if #available(iOS 10.0, *) {
            self.init(context: CoreDataDriver.shared.context)
        } else {
            // Fallback on earlier versions'
            let entityDescription = NSEntityDescription.entity(forEntityName: "LMedia", in: CoreDataDriver.shared.context)!
            self.init(entity: entityDescription, insertInto: CoreDataDriver.shared.context)
        }
    }
}



extension LMedia {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LMedia> {
        return NSFetchRequest<LMedia>(entityName: "LMedia")
    }

    @NSManaged public var id: String
    @NSManaged public var url: String

}

extension LMedia : Identifiable {}

extension LMedia {
    static func map(_ value: RMedia) -> LMedia {
        let entity = LMedia()
        entity.id = String(value.id)
        entity.url = value.url
        return entity
    }
}

