//
//  User.swift
//  Dash_Assessment
//
//  Created by ADMIN on 1/18/23.
//

import Foundation


public struct Tourist {
    var id: String = ""
    var touristName: String = ""
    var touristProfilepicture: String = ""
    var touristLocation: String = ""
    
    init() {}
    
    
    static func map(_ value: RTourist) -> Tourist {
        var model = Tourist()
        model.id = String(value.id)
        model.touristLocation = value.touristLocation
        model.touristName = value.touristName
        model.touristProfilepicture = value.touristProfilepicture
        return model
    }
    
    static func map(_ value: LTourist) -> Tourist {
        var model = Tourist()
        model.id = String(value.id)
        model.touristLocation = value.touristLocation
        model.touristName = value.touristName
        model.touristProfilepicture = value.touristProfilepicture
        return model
    }
}
