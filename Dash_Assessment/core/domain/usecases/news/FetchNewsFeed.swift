//
//  FetchNewsFeed.swift
//  Dash_Assessment
//
//  Created by ADMIN on 1/18/23.
//

import Foundation


protocol FetchNewsFeedUseCase {
    typealias SuccessCompletion = ([News]) -> Void
    typealias FailureCompletion = (String) -> Void
    
    func execute(page: Int, success: @escaping SuccessCompletion, error: @escaping FailureCompletion)
}


extension DefaultFetchNewsFeedUseCase {
    
    static func register() -> FetchNewsFeedUseCase {
        let repository = DefaultNewsRespository.register()
        return DefaultFetchNewsFeedUseCase.init(repository)
    }
}


final class DefaultFetchNewsFeedUseCase: FetchNewsFeedUseCase {
    
    
    private let repository: NewsRespository
    private var successHandler : SuccessCompletion?
    private var errorHandler: FailureCompletion?
    
    init(_ repository: NewsRespository) {
        self.repository = repository
    }
      
    
    func execute(page: Int, success: @escaping SuccessCompletion, error: @escaping FailureCompletion) {
        self.successHandler = success
        self.errorHandler = error
        let queryResult = repository.local.fetch(LNews.self)
        if !queryResult.items.isEmpty {
            let items = queryResult.items.compactMap(News.map)
            self.successHandler?(items)
        }
        
        repository.fetch(page: page) { [weak self] result in
            guard let self = self else { return }
            self.onExecuted(result)
        }
    }

}


private extension DefaultFetchNewsFeedUseCase {
    
    func onExecuted(_ result: Result<[RNews], ResponseError>) {
        switch result {
        case let .failure(error):
            self.errorHandler?(error.localDescription)
        case var .success(items):
            let queryResult = repository.local.fetch(LNews.self)
            let ids = Set(queryResult.items.compactMap({ Int($0.id) ?? 0 }))
            let itemsl = items.filter({ !ids.contains($0.id) })
            
            let entities = itemsl.compactMap(LNews.map)
            let models = itemsl.compactMap(News.map) + queryResult.items.compactMap(News.map)
            repository.save(entities)
            successHandler?(models)
        }
    }
}
