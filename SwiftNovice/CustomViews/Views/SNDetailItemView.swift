//
//  SNDetailItemView.swift
//  SwiftNovice
//
//  Created by Noah Pope on 7/23/24.
//

import UIKit

enum ImageType {
    case bio, price
}

class SNDetailItemView: UIView {

    let iconImageView       = UIImageView()
    let bodyLabel           = UILabel()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func set(imageType: ImageType, text: String) {
        switch imageType {
        case .bio:
            iconImageView.image = SFSymbols.bio
        case .price:
            iconImageView.image = SFSymbols.price
        }
        bodyLabel.text  = text
    }
    
    
    private func configure() {
        addSubviews(iconImageView, bodyLabel)
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        bodyLabel.translatesAutoresizingMaskIntoConstraints     = false
        
        iconImageView.tintColor     = .label
        iconImageView.contentMode   = .scaleAspectFill
        
        bodyLabel.textAlignment     = .left
        bodyLabel.font              = UIFont.systemFont(ofSize: 15)
        bodyLabel.lineBreakMode     = .byTruncatingTail
        bodyLabel.numberOfLines     = 0
        
        let imageToLabelPadding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: self.topAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: 20),
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            
            bodyLabel.topAnchor.constraint(equalTo: self.topAnchor),
            bodyLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: imageToLabelPadding),
            bodyLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
