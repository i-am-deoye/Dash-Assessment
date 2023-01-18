//
//  HomePage.swift
//  Dash_Assessment
//
//  Created by ADMIN on 1/18/23.
//

import UIKit


final  class HomePage: ContentPage<HomeContent> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        registerChildPages {
            var container = [UIViewController]()
            container.append(NewsFeedPage.init(style: UITableView.Style.plain))
            container.append(TouristsPage.init(style: UITableView.Style.plain))
            return container
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.containerContentView = self.contentView.content
    }
    
    private func bind() {
        contentView.segementsActionHandler = selected
    }
    
    private func selected(_ segement: HomeContent.Segements) {
        self.add(page: segement.rawValue)
    }
}
