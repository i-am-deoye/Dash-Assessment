//
//  User.swift
//  Dash_Assessment
//
//  Created by ADMIN on 1/18/23.
//

import Foundation


public struct User {
    var userid: String = ""
    var name: String = ""
    var profilepicture: String = ""
    
    init() {}
    
    
    static func map(_ value: RUser) -> User {
        var model = User()
        model.userid = String(value.userid)
        model.name = value.name ?? ""
        model.profilepicture = value.profilepicture ?? ""
        return model
    }
    
    
    static func map(_ value: LUser) -> User {
        var model = User()
        model.userid = value.id
        model.name = value.name
        model.profilepicture = value.picture 
        return model
    }
}
