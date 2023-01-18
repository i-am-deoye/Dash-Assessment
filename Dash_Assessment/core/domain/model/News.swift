//
//  News.swift
//  Dash_Assessment
//
//  Created by ADMIN on 1/18/23.
//

import Foundation


struct News {
    var id: String = ""
    var title: String = ""
    var description: String = ""
    var location: String = ""
    var multiMedia: [Media] = []
    var user: User?
    
    init() {}
    
    
    static func map(_ value: RNews) -> News {
        var model = News()
        model.id = String(value.id)
        model.location = value.location
        model.title = value.title ?? ""
        model.description = value.description ?? ""
        model.multiMedia = value.multiMedia.compactMap(Media.map)
        model.user = User.map(value.user)
        return model
    }
    
    static func map(_ value: LNews) -> News {
        var model = News()
        model.id = String(value.id)
        model.location = value.location
        model.title = value.title
        model.description = value.details
        model.multiMedia = Array<LMedia>(_immutableCocoaArray: value.multiMedia).compactMap(Media.map)
        model.user = User.map(value.user)
        return model
    }
}
