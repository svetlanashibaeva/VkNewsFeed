//
//  FooterView.swift
//  VkNewsFeed
//
//  Created by Света Шибаева on 16.12.2022.
//

import UIKit

final class FooterView: UIView {
    
    private let myLabel = UILabel()
    private let loader = UIActivityIndicatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
   
        configure()
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showLoader() {
        loader.startAnimating()
    }
    
    func setTitle(_ title: String?) {
        loader.stopAnimating()
        myLabel.text = title
    }
}

private extension FooterView {
    
    func configure() {
        myLabel.font = UIFont.systemFont(ofSize: 13)
        myLabel.textColor = .lightGray
        myLabel.textAlignment = .center
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.hidesWhenStopped = true
    }
    
    func addSubviews() {
        addSubview(myLabel)
        addSubview(loader)
    }
    
    func makeConstraints() {
        myLabel.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: trailingAnchor,
            padding: UIEdgeInsets(top: 8, left: 20, bottom: 777, right: 20)
        )
        
        loader.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loader.topAnchor.constraint(equalTo: myLabel.bottomAnchor, constant: 8).isActive = true
    }
}
