//
//  IViewModel.swift
//  Dash_Assessment
//
//  Created by ADMIN on 1/18/23.
//

import Foundation


protocol IViewModel {
    var start: (() -> Void)? { get set }
    var finished: (() -> Void)? { get set }
    var error: ((String) -> Void)? { get set }
}

