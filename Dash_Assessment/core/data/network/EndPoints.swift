//
//  EndPoints.swift
//  Dash_Assessment
//
//  Created by ADMIN on 1/18/23.
//

import Foundation


public protocol EndPoints {
    var rawvalue: String { get }
    func base() -> String
}


extension EndPoints {

    public var absoluteString: String {
        return base()+rawvalue
    }
    
    public var url: URL {
        guard let url = URL.init(string: absoluteString) else {
            preconditionFailure("The url used in \(EndPoints.self) is not valid")
        }
        
        return url
    }
}

extension String {
    func param(key: String, with value: String) -> String {
        let value = value.replacingOccurrences(of: " ", with: "%20")
        return self.replacingOccurrences(of: key, with: value)
    }
    
    var url: URL? {
        return URL(string: self)
    }
}


protocol APIEndpoint: EndPoints {}

enum Environment: String {
    case Debug
    case Release
}

extension APIEndpoint {
    func base() -> String {
        guard let currentConfiguration = Bundle.main.object(forInfoDictionaryKey: "Configuration") as? String else {
            fatalError("Configuration not setup properly")
        }
        
        if let environment = Environment(rawValue: currentConfiguration) {
            switch environment {
            case .Debug:
                return "http://restapi.adequateshop.com"
            case .Release:
                return "http://restapi.adequateshop.com"
            }
        }
        return "http://restapi.adequateshop.com"
    }
}
