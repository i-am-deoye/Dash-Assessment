//
//  Segueable.swift
//  Dash_Assessment
//
//  Created by ADMIN on 1/18/23.
//

import Foundation


protocol Segueable {
    associatedtype T
    var data : T? { get set }
}
