//
//  LNews.swift
//  Dash_Assessment
//
//  Created by ADMIN on 1/18/23.
//

import Foundation
import CoreData

@objc(LNews)
public class LNews: NSManagedObject {
    convenience init() {
        if #available(iOS 10.0, *) {
            self.init(context: CoreDataDriver.shared.context)
        } else {
            // Fallback on earlier versions'
            let entityDescription = NSEntityDescription.entity(forEntityName: "LNews", in: CoreDataDriver.shared.context)!
            self.init(entity: entityDescription, insertInto: CoreDataDriver.shared.context)
        }
    }
}



extension LNews {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LNews> {
        return NSFetchRequest<LNews>(entityName: "LNews")
    }

    @NSManaged public var id: String
    @NSManaged public var title: String
    @NSManaged public var details: String
    @NSManaged public var location: String
    @NSManaged public var multiMedia: NSSet
    @NSManaged public var user: LUser

}

extension LNews : Identifiable {}

extension LNews {
    static func map(_ value: RNews) -> LNews {
        let entity = LNews()
        entity.id = String(value.id)
        entity.location = value.location
        entity.title = value.title ?? ""
        entity.details = value.description ?? ""
        entity.multiMedia = NSSet.init(array: value.multiMedia.compactMap(LMedia.map))
        entity.user = LUser.map(value.user)
        return entity
    }
}
