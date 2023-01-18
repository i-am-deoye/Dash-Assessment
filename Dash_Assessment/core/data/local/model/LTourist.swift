//
//  LTourist.swift
//  Dash_Assessment
//
//  Created by ADMIN on 1/18/23.
//

import Foundation
import CoreData

@objc(LTourist)
public class LTourist: NSManagedObject {
    convenience init() {
        if #available(iOS 10.0, *) {
            self.init(context: CoreDataDriver.shared.context)
        } else {
            // Fallback on earlier versions'
            let entityDescription = NSEntityDescription.entity(forEntityName: "LTourist", in: CoreDataDriver.shared.context)!
            self.init(entity: entityDescription, insertInto: CoreDataDriver.shared.context)
        }
    }
}



extension LTourist {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LTourist> {
        return NSFetchRequest<LTourist>(entityName: "LTourist")
    }

    @NSManaged public var id: String
    @NSManaged public var touristName: String
    @NSManaged public var touristProfilepicture: String
    @NSManaged public var touristLocation: String

}

extension LTourist : Identifiable {}


extension LTourist {
    static func map(_ value: RTourist) -> LTourist {
        let entity = LTourist()
        entity.id = String(value.id)
        entity.touristLocation = value.touristLocation
        entity.touristName = value.touristName
        entity.touristProfilepicture = value.touristProfilepicture
        return entity
    }
}

