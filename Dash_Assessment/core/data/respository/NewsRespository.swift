//
//  NewsRespository.swift
//  Dash_Assessment
//
//  Created by ADMIN on 1/18/23.
//

import Foundation


private enum NewstEndpoints: String, APIEndpoint {
    
    case getNewsFeed = "/api/Feed/GetNewsFeed?"
    
    var rawvalue: String {
        return rawValue
    }
}


protocol NewsRespository: IRemoteRepository, ILocalRepository {
    typealias FetchNewsFeedCompletion = (Result<[RNews], ResponseError>) -> Void
    
    func fetch(page: Int, result completion: @escaping FetchNewsFeedCompletion)
}

extension DefaultNewsRespository {
    
    static func register() -> NewsRespository {
        let repository = DefaultNewsRespository.init(client: URLSessionHTTPClient(), local: CoreDataDriver.shared)
        return repository
    }
}


final class DefaultNewsRespository: NewsRespository {
    var client: HTTPClient
    var local: IDataBaseDriver
    
    private var fetchNewsFeedCompletion: FetchNewsFeedCompletion?
    
    init(client: HTTPClient, local: IDataBaseDriver) {
        self.client = client
        self.local = local
    }
    
    
    func fetch(page: Int, result completion: @escaping FetchNewsFeedCompletion) {
        self.fetchNewsFeedCompletion = completion
        
        guard let url = NewstEndpoints.getNewsFeed.absoluteString.param(key: "{page}", with: "\(page)").url else {
            completion(.failure(ResponseError.general))
            return
        }
        client.get(from: url) {[weak self] result in
            guard let self = self else { return }
            self.onFetched(result)
        }
    }
}


private extension DefaultNewsRespository {
    
    func onFetched(_ result: HTTPClient.Result ) {
        self.onResponse(result) {[weak self] (data: [RNews]) in
            guard let self = self else { return }
            self.fetchNewsFeedCompletion?(.success(data))
        } resultError: { [weak self] error in
            guard let self = self else { return }
            self.fetchNewsFeedCompletion?(.failure(error))
        }
    }
    
}
