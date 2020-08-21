//
//  ArticleTableViewCell.swift
//  NewsApp
//
//  Created by admios on 8/19/20.
//  Copyright © 2020 rene. All rights reserved.
//

import Foundation
import UIKit

class ArticleTableViewCell: UITableViewCell {
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.frame.size.width = 30
        label.sizeToFit()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.clipsToBounds = true
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .darkGray
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(descriptionLabel)
        
        titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 12.0).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 12).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -12).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.descriptionLabel.topAnchor, constant: -8).isActive = true

        descriptionLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 12.0).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 12).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -12).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8).isActive = true

    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
