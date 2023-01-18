//
//  TouristDetailsPage.swift
//  Dash_Assessment
//
//  Created by ADMIN on 1/18/23.
//

import UIKit


extension TouristDetailsPage {
    static func register(_ controller: TouristDetailsPage) {
        controller.viewmodel = DefaultTouristsViewModel.register()
    }
    
    static func present(_ controller: UIViewController, with data: Tourist) {
        let page = TouristDetailsPage.init()
        page.data = data
        controller.show(page, sender: nil)
    }
}

final class TouristDetailsPage: UIViewController, Segueable {
    typealias T = Tourist
    internal var viewmodel: TouristsViewModel!
    var data: Tourist?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var details: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        setup()
    }
    
    
    private func setup() {
        TouristDetailsPage.register(self)
        navigationItem.title = "Tourist Details"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        
        titleLabel.text = data?.touristName ?? ""
        details.text = (data?.touristProfilepicture ?? "") + "   " + (data?.touristLocation ?? "")
        
        let content = UIStackView.init(arrangedSubviews: [titleLabel, details])
        content.axis = .vertical
        content.spacing = 16
        content.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(content)
        
        NSLayoutConstraint.activate([
            content.safeAreaLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            content.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            content.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
}
