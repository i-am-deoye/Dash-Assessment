//
//  LUser.swift
//  Dash_Assessment
//
//  Created by ADMIN on 1/18/23.
//

import Foundation
import CoreData

@objc(LUser)
public class LUser: NSManagedObject {
    convenience init() {
        if #available(iOS 10.0, *) {
            self.init(context: CoreDataDriver.shared.context)
        } else {
            // Fallback on earlier versions'
            let entityDescription = NSEntityDescription.entity(forEntityName: "LUser", in: CoreDataDriver.shared.context)!
            self.init(entity: entityDescription, insertInto: CoreDataDriver.shared.context)
        }
    }
}



extension LUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LUser> {
        return NSFetchRequest<LUser>(entityName: "LUser")
    }

    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var picture: String

}

extension LUser : Identifiable {}


extension LUser {
    static func map(_ value: RUser) -> LUser {
        let entity = LUser()
        entity.id = String(value.userid)
        entity.name = value.name ?? ""
        entity.picture = value.profilepicture ?? ""
        return entity
    }
}

