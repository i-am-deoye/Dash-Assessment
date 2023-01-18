//
//  RUser.swift
//  Dash_Assessment
//
//  Created by ADMIN on 1/18/23.
//

import Foundation


public struct RTourist: Responseable {
    let id: Int
    let touristName: String
    var touristProfilepicture: String = ""
    let touristLocation: String
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case touristName = "tourist_name"
        case touristLocation = "tourist_location"
    }
}

