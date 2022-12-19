//
//  GalleryCollectionViewCell.swift
//  VkNewsFeed
//
//  Created by Света Шибаева on 02.12.2022.
//

import UIKit

final class GalleryCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "GalleryCollectionViewCell"
    
    private let myImageView = WebImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        myImageView.image = nil
    }
    
    func set(imageUrl: String?) {
        myImageView.set(imageURL: imageUrl)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        myImageView.layer.masksToBounds = true
        myImageView.layer.cornerRadius = 10
        self.layer.shadowRadius = 3
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 2.5, height: 4)
    }
}

private extension GalleryCollectionViewCell {
    
    func configure() {
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        myImageView.contentMode = .scaleAspectFill
        myImageView.backgroundColor = .lightGray
    }
    
    func addSubviews() {
        addSubview(myImageView)
    }
    
    func makeConstraints() {
        myImageView.fillSuperview()
    }
}
