//
//  TouristsPage.swift
//  Dash_Assessment
//
//  Created by ADMIN on 1/18/23.
//

import UIKit


extension TouristsPage {
    static func register(_ controller: TouristsPage) {
        controller.viewmodel = DefaultTouristsViewModel.register()
    }
}

final class TouristsPage: UITableViewController {
    internal var viewmodel: TouristsViewModel!
    
    
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
        TouristsPage.register(self)
        NotificationHelper.observe(self, selector: #selector(fetch), name: .ShouldUpdatesUI)
        navigationItem.title = "Tourist List"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(progressView)
        
        NSLayoutConstraint.activate([
            progressView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        tableView.register(TouristCell.self, forCellReuseIdentifier: TouristCell.identifier)
    }
}
