//
//  NewsFeedViewModel.swift
//  Dash_Assessment
//
//  Created by ADMIN on 1/18/23.
//

import Foundation

protocol NewsFeedViewModel: IViewModel {
    var newsfeed: [News] { get set }
    var newsfeedCount: Int { get }
    
    func fetchNewsFeed(by page: Int)
    func getNews(by index: Int) -> News
}


extension DefaultNewsFeedViewModel {
    
    static func register() -> NewsFeedViewModel {
        let usecase = DefaultFetchNewsFeedUseCase.register()
        return DefaultNewsFeedViewModel.init(usecase)
    }
}


final class DefaultNewsFeedViewModel: NewsFeedViewModel {

    var error: ((String) -> Void)?
    var newsfeed = [News]()
    var newsfeedCount: Int {
        return newsfeed.count
    }
    
    
    var start: (() -> Void)?
    var finished: (() -> Void)?
    
    
    private let usecase: FetchNewsFeedUseCase
    
    fileprivate init(_ usecase: FetchNewsFeedUseCase) {
        self.usecase = usecase
    }
    
    
    func fetchNewsFeed(by page: Int) {
        start?()
        usecase.execute(page: page, success: {[weak self] newsfeed in
            guard let self = self else { return }
            self.newsfeed = newsfeed
            self.finished?()
        }, error: {[weak self] message in
            guard let self = self else { return }
            self.error?(message)
            self.finished?()
        })
    }
    
    func getNews(by index: Int) -> News {
        guard index < newsfeedCount else { fatalError("index out of range") }
        return newsfeed[index]
    }
    
    
    
}
