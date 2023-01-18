//
//  FetchTourists.swift
//  Dash_Assessment
//
//  Created by ADMIN on 1/18/23.
//

import Foundation



protocol FetchTouristsFeedUseCase {
    typealias SuccessCompletion = ([Tourist]) -> Void
    typealias FailureCompletion = (String) -> Void
    
    func execute(page: Int, success: @escaping SuccessCompletion, error: @escaping FailureCompletion)
}


extension DefaultFetchTouristsFeedUseCase {
    
    static func register() -> FetchTouristsFeedUseCase {
        let repository = DefaultTouristRepository.register()
        return DefaultFetchTouristsFeedUseCase.init(repository)
    }
}


final class DefaultFetchTouristsFeedUseCase: FetchTouristsFeedUseCase {
    
    
    private let repository: TouristRepository
    private var successHandler : SuccessCompletion?
    private var errorHandler: FailureCompletion?
    
    init(_ repository: TouristRepository) {
        self.repository = repository
    }
      
    
    func execute(page: Int, success: @escaping SuccessCompletion, error: @escaping FailureCompletion) {
        self.successHandler = success
        self.errorHandler = error
        let queryResult = repository.local.fetch(LTourist.self)
        if !queryResult.items.isEmpty {
            let items = queryResult.items.compactMap(Tourist.map)
            self.successHandler?(items)
        }
        
        repository.fetch(page: page) { [weak self] result in
            guard let self = self else { return }
            self.onExecuted(result)
        }
    }

}


private extension DefaultFetchTouristsFeedUseCase {
    
    func onExecuted(_ result: Result<[RTourist], ResponseError>) {
        switch result {
        case let .failure(error):
            self.errorHandler?(error.localDescription)
        case var .success(items):
            let queryResult = repository.local.fetch(LTourist.self)
            let ids = Set(queryResult.items.compactMap({ Int($0.id) ?? 0 }))
            let itemsl = items.filter({ !ids.contains($0.id) })
            
            let entities = itemsl.compactMap(LTourist.map)
            let models = itemsl.compactMap(Tourist.map) + queryResult.items.compactMap(Tourist.map)
            repository.save(entities)
            successHandler?(models)
        }
    }
}
