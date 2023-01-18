//
//  NotificationHelper.swift
//  Dash_Assessment
//
//  Created by ADMIN on 1/18/23.
//

import Foundation


public class NotificationHelper {
    
    public static func post(_ name: NSNotification.Name, object: Any?, userInfo: [AnyHashable: Any]?) {
        NotificationCenter.default.post(name: name, object: object, userInfo: userInfo)
    }
    
    
    public static func observe(_ receiver: Any, selector: Selector, name: NSNotification.Name) {
        NotificationCenter.default.addObserver(receiver, selector: selector, name: name, object: nil)
    }
    
    public static func remove(_ receiver: Any) {
        NotificationCenter.default.removeObserver(receiver)
    }
    
    public static func remove(_ receiver: Any, name: NSNotification.Name) {
        NotificationCenter.default.removeObserver(receiver, name: name, object: nil)
    }
}



extension NSNotification.Name {
    public static let ShouldUpdatesUI = NSNotification.Name.init("ShouldUpdatesUI")
}


extension NotificationHelper {
    
   static func shouldUpdatesUI() {
       NotificationHelper.post(.ShouldUpdatesUI, object: nil, userInfo: nil)
    }
}
