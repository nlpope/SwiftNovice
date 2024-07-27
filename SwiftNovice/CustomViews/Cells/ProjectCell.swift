//
//  ProjectCell.swift
//  SwiftNovice
//
//  Created by Noah Pope on 7/26/24.
//

import UIKit

class ProjectCell: UITableViewCell {

    static let reuseID      = "ProjectCell"
    let avatarImageView     = SNAvatarImageView(frame: .zero)
    let contentNameLabel    = SNTitleLabel(textAlignment: .left, fontSize: 26, lineBreakMode: .byTruncatingTail)
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(project: Project) {
        contentNameLabel.text = project.projectName
        avatarImageView.image = Images.placeholder
        avatarImageView.downloadImage(fromURL: project.avatarUrl)
    }
    
    
    private func configure() {
        addSubviews(avatarImageView, contentNameLabel)
        accessoryType                   = .disclosureIndicator
        
        let padding: CGFloat            = 12
        let textImagePadding: CGFloat   = 24
        
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            
            contentNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            contentNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            contentNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            contentNameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
