//
//  RNews.swift
//  Dash_Assessment
//
//  Created by ADMIN on 1/18/23.
//

import Foundation


struct RNews: Responseable {
    let id: Int
    let title: String?
    let description: String?
    let location: String
    let multiMedia: [RMedia]
    let user: RUser
}
