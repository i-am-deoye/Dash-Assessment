//
//  Media.swift
//  Dash_Assessment
//
//  Created by ADMIN on 1/18/23.
//

import Foundation


public struct Media {
    var id: String = ""
    var url: String = ""
    
    init() {}
    
    static func map(_ value: RMedia) -> Media {
        var model = Media()
        model.id = String(value.id)
        model.url = value.url
        return model
    }
    
    static func map(_ value: LMedia) -> Media {
        var model = Media()
        model.id = String(value.id)
        model.url = value.url
        return model
    }
}
