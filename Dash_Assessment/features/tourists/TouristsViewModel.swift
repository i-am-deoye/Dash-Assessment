//
//  NewsViewModel.swift
//  Dash_Assessment
//
//  Created by ADMIN on 1/18/23.
//

import Foundation


protocol TouristsViewModel: IViewModel {
    var tourists: [Tourist] { get set }
    var touristsCount: Int { get }
    
    func fetchTourists(by page: Int)
    func getTourist(by index: Int) -> Tourist
}


extension DefaultTouristsViewModel {
    
    static func register() -> TouristsViewModel {
        let usecase = DefaultFetchTouristsFeedUseCase.register()
        return DefaultTouristsViewModel.init(usecase)
    }
}


final class DefaultTouristsViewModel: TouristsViewModel {

    var error: ((String) -> Void)?
    var tourists = [Tourist]()
    var touristsCount: Int {
        return tourists.count
    }
    
    
    var start: (() -> Void)?
    var finished: (() -> Void)?
    
    
    private let usecase: FetchTouristsFeedUseCase
    
    fileprivate init(_ usecase: FetchTouristsFeedUseCase) {
        self.usecase = usecase
    }
    
    
    func fetchTourists(by page: Int) {
        start?()
        usecase.execute(page: page, success: {[weak self] users in
            guard let self = self else { return }
            self.tourists = users
            self.finished?()
        }, error: {[weak self] message in
            guard let self = self else { return }
            self.error?(message)
            self.finished?()
        })
    }
    
    func getTourist(by index: Int) -> Tourist {
        guard index < touristsCount else { fatalError("index out of range") }
        return tourists[index]
    }
    
    
    
}
