//
//  NewsFeedPage.swift
//  Dash_Assessment
//
//  Created by ADMIN on 1/18/23.
//

import UIKit


extension NewsFeedPage {
    static func register(_ controller: NewsFeedPage) {
        controller.viewmodel = DefaultNewsFeedViewModel.register()
    }
}


final class NewsFeedPage: UITableViewController, Segueable {
    typealias T = String
    
    internal var viewmodel: NewsFeedViewModel!
    var data: String?
    
    
    lazy var progressView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    private func setup() {
        NewsFeedPage.register(self)
        NotificationHelper.observe(self, selector: #selector(fetch), name: .ShouldUpdatesUI)
        navigationItem.title = "News Feed"
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(progressView)
        
        NSLayoutConstraint.activate([
            progressView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.identifier)
    }
}

