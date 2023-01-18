//
//  HomeContent.swift
//  Dash_Assessment
//
//  Created by ADMIN on 1/18/23.
//

import UIKit



extension HomeContent {
    enum Segements: Int {
        case newsfeed = 0
        case tourists = 1
    }
}

final class HomeContent: ContentView {
    var segementsActionHandler: ((Segements) -> Void)?
    
    fileprivate lazy var selectedSegement: Segements = .newsfeed
    
    fileprivate lazy var newsFeedButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.textAlignment = .left
        button.backgroundColor = .clear
        button.setTitle("News Feed", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(newsFeedAction), for: .touchUpInside)
        return button
    }()
    
    fileprivate lazy var touristsButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.textAlignment = .left
        button.backgroundColor = .clear
        button.setTitle("Tourist List", for: .normal)
        button.titleLabel?.font =  UIFont.systemFont(ofSize: 20)
        button.setTitleColor(.darkGray, for: .normal)
        button.addTarget(self, action: #selector(touristsAction), for: .touchUpInside)
        return button
    }()
    
    
    
    fileprivate lazy var segementStack: UIStackView = {
        let stack = UIStackView.init(arrangedSubviews: [newsFeedButton, touristsButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    
    
    
    lazy var content: ContentView = {
        let content = ContentView()
        content.backgroundColor = .white
        content.translatesAutoresizingMaskIntoConstraints = false
        return content
    }()
    
    
    
    
    override func setup() {
        backgroundColor = UIColor.white
        addSubview(segementStack)
        addSubview(content)
        
        NSLayoutConstraint.activate([
            segementStack.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            segementStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            segementStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            segementStack.heightAnchor.constraint(equalToConstant: 35)
        ])
        
        NSLayoutConstraint.activate([
            content.leadingAnchor.constraint(equalTo: leadingAnchor),
            content.trailingAnchor.constraint(equalTo: trailingAnchor),
            content.bottomAnchor.constraint(equalTo: bottomAnchor),
            content.topAnchor.constraint(equalTo: segementStack.bottomAnchor, constant: 16)
        ])
    }
    
    
    @objc private func newsFeedAction() {
        if selectedSegement == .newsfeed { return }
        touristsButton.setTitleColor(UIColor.darkGray, for: .normal)
        newsFeedButton.setTitleColor(.black, for: .normal)
        selectedSegement = .newsfeed
        segementsActionHandler?(.newsfeed)
    }
    
    @objc private func touristsAction() {
        if selectedSegement == .tourists { return }
        touristsButton.setTitleColor(.black, for: .normal)
        newsFeedButton.setTitleColor(.darkGray, for: .normal)
        selectedSegement = .tourists
        segementsActionHandler?(.tourists)
    }
}

