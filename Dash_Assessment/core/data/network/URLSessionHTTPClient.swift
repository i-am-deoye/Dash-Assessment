//
//  URLSessionHTTPClient.swift
//  Dash_Assessment
//
//  Created by ADMIN on 1/18/23.
//

import Foundation



final class URLSessionHTTPClient : HTTPClient {
    var headers: HTTPClient.HTTPHeaders = HTTPClient.HTTPHeaders.init()
    
    private lazy var session : URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = 1200
        return URLSession.init(configuration: configuration)
    }()
    
    
    private func dataTaskPublisher(for request: URLRequest, completion: @escaping HTTPClient.CompletionResult ) {
        var request = request
        self.setDefaultHeaders(&request)
        request.allHTTPHeaderFields = headers
        
        session.dataTask(with: request, completionHandler: { [weak self] data, response, error in
            guard self != nil else { return }
            DispatchQueue.main.async {
                if let data = data {
                    completion(.success((data, response as! HTTPURLResponse)))
                } else if let error = error {
                    completion(.failure(ResponseError.otherCause(message: error.localizedDescription)))
                } else {
                    completion(.failure(ResponseError.general))
                }
            }
        }).resume()
    }
    
    
    
    func get(from url: URL, completion: @escaping HTTPClient.CompletionResult )  {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        dataTaskPublisher(for: request, completion: completion)
    }
    
}
