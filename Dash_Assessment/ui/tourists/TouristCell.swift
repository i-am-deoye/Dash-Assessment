//
//  TouristCell.swift
//  Dash_Assessment
//
//  Created by ADMIN on 1/18/23.
//

import UIKit

final class TouristCell: UITableViewCell {
    static let identifier = "\(String(describing: TouristCell.self))"
    
    private let bottomOffset : CGFloat = 0
    private let thumbnailSize: CGFloat = 35
    private let titleHeight: CGFloat = 35
    
    private let horizontalMargins: CGFloat = 8
    private let verticalMargins: CGFloat = 8
    private let verticalOffset: CGFloat = 8
    private let horizontalOffset: CGFloat = 8
    
    
    
    
    
    private lazy var fullname: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    private lazy var content : UIView = {
        let content = UIView.init()
        content.translatesAutoresizingMaskIntoConstraints = false
        
        content.addSubview(fullname)
        
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
            fullname.topAnchor.constraint(equalTo: content.topAnchor),
            fullname.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: horizontalOffset),
            fullname.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -horizontalMargins),
            fullname.bottomAnchor.constraint(equalTo: content.bottomAnchor)
        ])

    }
    
    func set(_ user: Tourist) {
        fullname.text = user.touristName
    }
    
}

