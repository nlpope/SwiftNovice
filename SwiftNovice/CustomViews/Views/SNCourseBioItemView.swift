//
//  SNCourseBioItemView.swift
//  SwiftNovice
//
//  Created by Noah Pope on 7/23/24.
//

import UIKit

enum ImageType {
    case bio, price
}

class SNCourseBioItemView: UIView {

    let courseTitleLabel    = SNTitleLabel(textAlignment: .left, fontSize: 30)
    let bioImageView        = UIImageView()
    let bioBodyLabel        = SNBodyLabel(textAlignment: .left)
    let priceImageView      = UIImageView()
    let priceLabel          = SNSecondaryTitleLabel(fontSize: 18)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepImageView(forImageView: bioImageView, imageType: .bio)
        prepImageView(forImageView: priceImageView, imageType: .price)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func prepImageView(forImageView imageView: UIImageView, imageType: ImageType) {
        imageView.translatesAutoresizingMaskIntoConstraints      = false
        imageView.contentMode                                    = .scaleAspectFill
        imageView.tintColor                                      = .label
        
        switch imageType {
        case .bio:
            imageView.image = SFSymbols.book
        case .price:
            imageView.image = SFSymbols.price
        }
    }

    
    func set(courseTitle: String, bioText: String, price: Double) {
        courseTitleLabel.text    = courseTitle
        bioBodyLabel.text            = bioText
        priceLabel.text          = String(price)
        
    }
    
    
    private func configure() {
        addSubviews(courseTitleLabel, bioImageView, bioBodyLabel, priceImageView, priceLabel)
        let textImagePadding: CGFloat = 5
        
        NSLayoutConstraint.activate([
            courseTitleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            courseTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            courseTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            courseTitleLabel.heightAnchor.constraint(equalToConstant: 34),
            
            bioImageView.topAnchor.constraint(equalTo: courseTitleLabel.bottomAnchor, constant: 10),
            bioImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bioImageView.heightAnchor.constraint(equalToConstant: 20),
            bioImageView.widthAnchor.constraint(equalToConstant: 20),
            
            bioBodyLabel.topAnchor.constraint(equalTo: courseTitleLabel.bottomAnchor, constant: 10),
            bioBodyLabel.leadingAnchor.constraint(equalTo: bioImageView.trailingAnchor, constant: textImagePadding),
            bioBodyLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            priceImageView.topAnchor.constraint(equalTo: bioBodyLabel.bottomAnchor, constant: 50),
            priceImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            priceImageView.heightAnchor.constraint(equalToConstant: 20),
            priceImageView.widthAnchor.constraint(equalToConstant: 20),
            
            priceLabel.topAnchor.constraint(equalTo: bioBodyLabel.bottomAnchor, constant: 50),
            priceLabel.leadingAnchor.constraint(equalTo: priceImageView.trailingAnchor, constant: textImagePadding),
            priceLabel.heightAnchor.constraint(equalToConstant: 20)
            
        ])
    }

}
