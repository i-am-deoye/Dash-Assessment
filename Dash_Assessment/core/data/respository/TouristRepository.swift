//
//  TouristRepository.swift
//  Dash_Assessment
//
//  Created by ADMIN on 1/18/23.
//

import Foundation


private enum TouristEndpoints: String, APIEndpoint {
    
    case getTourists = "/api/Tourist?page={page}"
    
    var rawvalue: String {
        return rawValue
    }
}




protocol TouristRepository: IRemoteRepository, ILocalRepository {
    typealias FetchTouristsCompletion = (Result<[RTourist], ResponseError>) -> Void
    
    func fetch(page: Int, result completion: @escaping FetchTouristsCompletion)
}


extension DefaultTouristRepository {
    
    static func register() -> TouristRepository {
        let repository = DefaultTouristRepository.init(client: URLSessionHTTPClient(), local: CoreDataDriver.shared)
        return repository
    }
}


final class DefaultTouristRepository: TouristRepository {
    var client: HTTPClient
    var local: IDataBaseDriver
    
    private var fetchTouristsCompletion: FetchTouristsCompletion?
    
    fileprivate init(client: HTTPClient, local: IDataBaseDriver) {
        self.client = client
        self.local = local
    }
    
    
    func fetch(page: Int, result completion: @escaping FetchTouristsCompletion) {
        self.fetchTouristsCompletion = completion
        
        guard let url = TouristEndpoints.getTourists.absoluteString.param(key: "{page}", with: "\(page)").url else {
            completion(.failure(ResponseError.general))
            return
        }
        client.get(from: url) {[weak self] result in
            guard let self = self else { return }
            self.onFetched(result)
        }
    }
}


private extension DefaultTouristRepository {
    
    func onFetched(_ result: HTTPClient.Result ) {
        self.onResponse(result) {[weak self] (data: [RTourist]) in
            guard let self = self else { return }
            self.fetchTouristsCompletion?(.success(data))
        } resultError: { [weak self] error in
            guard let self = self else { return }
            self.fetchTouristsCompletion?(.failure(error))
        }
    }
    
}
