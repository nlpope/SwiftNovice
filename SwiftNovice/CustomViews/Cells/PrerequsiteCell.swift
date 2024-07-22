//
//  PrerequsiteCell.swift
//  SwiftNovice
//
//  Created by Noah Pope on 7/21/24.
//

import UIKit

class PrerequisiteCell: UITableViewCell {

    static let reuseID  = "PrerequisiteCell"
    let avatarImageView = SNAvatarImageView(frame: .zero)
    let courseNameLabel = SNTitleLabel(textAlignment: .left, fontSize: 26)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(prerequisite: Prerequisite) {
        courseNameLabel.text = prerequisite.courseName
        avatarImageView.image = Images.placeholder
        avatarImageView.downloadImage(fromURL: prerequisite.avatarUrl)
    }
    
    
    private func configure() {
        addSubviews(avatarImageView, courseNameLabel)
        accessoryType                   = .disclosureIndicator
        
        let padding: CGFloat            = 12
        let textImagePadding: CGFloat   = 24
        
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            
            courseNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            courseNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            courseNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            courseNameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

