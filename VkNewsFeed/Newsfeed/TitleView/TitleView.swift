//
//  TitleView.swift
//  VkNewsFeed
//
//  Created by Света Шибаева on 13.12.2022.
//

import UIKit

protocol TitleViewViewModel {
    var photoUrlString: String? { get }
    var firstName: String? { get }
    var lastName: String? { get }
}

final class TitleView: UIView {
    
    private let myNameLabel = UILabel()
    private let myAvatarView = WebImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        addSubviews()
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(userViewModel: TitleViewViewModel) {
        myAvatarView.set(imageURL: userViewModel.photoUrlString)
        guard let firstName = userViewModel.firstName, let lastName = userViewModel.lastName else { return }
        myNameLabel.text = firstName + " " + lastName
    }
    
    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        myAvatarView.layer.cornerRadius = myAvatarView.frame.width / 2
        myAvatarView.layer.masksToBounds = true
    }
}

private extension TitleView {
    
    func configure() {
        myNameLabel.translatesAutoresizingMaskIntoConstraints = false
        myNameLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        myNameLabel.textAlignment = .center
        
        myAvatarView.translatesAutoresizingMaskIntoConstraints = false
        myAvatarView.backgroundColor = .blue
        myAvatarView.clipsToBounds = true
    }
    
    func addSubviews() {
        addSubview(myNameLabel)
        addSubview(myAvatarView)
    }
    
    func makeConstraints() {
        //myAvatar constraints
        myAvatarView.anchor(
            top: topAnchor,
            leading: nil,
            bottom: nil,
            trailing: trailingAnchor,
            padding: UIEdgeInsets(top: 4, left: 777, bottom: 777, right: 4)
        )
        myAvatarView.heightAnchor.constraint(equalTo: myNameLabel.heightAnchor, multiplier: 1).isActive = true
        myAvatarView.widthAnchor.constraint(equalTo: myNameLabel.heightAnchor, multiplier: 1).isActive = true
        
        //myTextField constraints
        myNameLabel.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            padding: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        )
    }
}
