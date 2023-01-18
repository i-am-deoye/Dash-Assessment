//
//  IRemoteRepository.swift
//  Dash_Assessment
//
//  Created by ADMIN on 1/18/23.
//

import Foundation


typealias SuccessResponse = (data: Data, response: HTTPURLResponse)

extension Int {
    var STATUS_CODE_OK: Bool {
        return Array(200...210).contains(self)
    }
}


public enum ResponseError: Swift.Error {
    case connectivity
    case invalidData
    case general
    case otherCause(message: String)
    
    public var localDescription: String {
        switch self {
        case .connectivity: return "unable to connect to the server"
        case .invalidData: return "unable to parse data."
        case .general: return "something went wrong, please try again later"
        case .otherCause(let message): return message
        }
    }
}


protocol IRemoteRepository {
    var client: HTTPClient { get }
}

extension IRemoteRepository {
    func onResponse<T:Responseable>(_ result: HTTPClient.Result,
                      resultData: @escaping (T) -> Void,
                      resultError: @escaping (ResponseError) -> Void) {
        switch result {
        case let .success(tupleResult as SuccessResponse):
            if !tupleResult.response.statusCode.STATUS_CODE_OK {
                resultError(.invalidData)
            } else {
                self.parse(tupleResult.data, resultData: resultData, resultError: resultError)
            }
        case .failure(_):
            resultError(.connectivity)
        }
    }
    
    private func parse<T:Responseable>(_ data: Data,
                                       resultData: @escaping (T) -> Void,
                                       resultError: @escaping (ResponseError) -> Void) {
        Logger.log(.i, messages: String.init(data: data, encoding: .utf8) ?? "")
        Logger.log(.i, messages: "TYPE \(T.self)")
        
        do {
            let response = try JSONDecoder().decode(Response<T>.self, from: data)
            resultData(response.data)
        } catch {
            resultError(.invalidData)
        }
    }
}

