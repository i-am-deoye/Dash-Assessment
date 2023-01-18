//
//  NewsCell.swift
//  Dash_Assessment
//
//  Created by ADMIN on 1/18/23.
//

import UIKit


final class NewsCell: UITableViewCell {
    static let identifier = "\(String(describing: NewsCell.self))"
    
    private let bottomOffset : CGFloat = 0
    private let thumbnailSize: CGFloat = 35
    private let titleHeight: CGFloat = 35
    
    private let horizontalMargins: CGFloat = 8
    private let verticalMargins: CGFloat = 8
    private let verticalOffset: CGFloat = 8
    private let horizontalOffset: CGFloat = 8
    
    
    
    
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
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
    
    private lazy var content : UIView = {
        let content = UIView.init()
        content.translatesAutoresizingMaskIntoConstraints = false
        
        content.addSubview(title)
        content.addSubview(details)
        
        return content
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(false, animated: animated)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }
    
    private func setup() {
        self.contentView.addSubview(content)
        content.safeAreaLayoutGuide.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor).isActive = true
        content.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: bottomOffset).isActive = true
        content.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        content.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        
        setupViewsConstraints()
    }
    
    private func setupViewsConstraints() {
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: content.topAnchor, constant: verticalOffset),
            title.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: horizontalMargins),
            title.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -horizontalMargins),
            title.heightAnchor.constraint(equalToConstant: titleHeight)
        ])
        
        NSLayoutConstraint.activate([
            details.topAnchor.constraint(equalTo: title.bottomAnchor, constant: verticalOffset),
            details.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: horizontalMargins),
            details.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -horizontalMargins),
            details.bottomAnchor.constraint(equalTo: content.bottomAnchor, constant: -verticalMargins)
        ])
    }
    
    func set(_ news: News) {
        
        title.text = news.title
        details.text = news.description
    }
    
}


