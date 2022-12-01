//
//  NewsfeedCodeCell.swift
//  VkNewsFeed
//
//  Created by Света Шибаева on 30.11.2022.
//

import UIKit

final class NewsfeedCodeCell: UITableViewCell {
    
    static let reuseId = "NewsfeedCodeCell"
    
    // первый слой
    let cardView = UIView()
    
    // второй слой
    let topView = UIView()
    let postLabel = UILabel()
    let postImageView = WebImageView()
    let bottomView = UIView()
    
    // третий слой на topView
    let iconImageView = WebImageView()
    let nameLabel = UILabel()
    let dateLabel = UILabel()
    
    // третий слой на bottomView
    let likesView = UIView()
    let commentsView = UIView()
    let sharesView = UIView()
    let viewsView = UIView()
    
    // четвертый слой на bottomView
    let likesImage = UIImageView()
    let commentsImage = UIImageView()
    let sharesImage = UIImageView()
    let viewsImage = UIImageView()
    let likesLabel = UILabel()
    let commentsLabel = UILabel()
    let sharesLabel = UILabel()
    let viewsLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        selectionStyle = .none
        
        cardView.layer.cornerRadius = 10
        cardView.clipsToBounds = true
        
        configure()
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(viewModel: FeedCellViewModel) {
        iconImageView.set(imageURL: viewModel.iconUrlString)
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        postLabel.text = viewModel.text
        likesLabel.text = viewModel.likes
        commentsLabel.text = viewModel.comments
        sharesLabel.text = viewModel.shares
        viewsLabel.text = viewModel.views
        
        postLabel.frame = viewModel.sizes.postLabelFrame
        postImageView.frame = viewModel.sizes.attachmentFrame
        bottomView.frame = viewModel.sizes.bottomViewFrame
        
        if let photoAttachment = viewModel.photoAttachment {
            postImageView.set(imageURL: photoAttachment.photoUrlString)
            postImageView.isHidden = false
        } else {
            postImageView.isHidden = true
        }
    }
}

private extension NewsfeedCodeCell {
    func configure() {
        cardView.backgroundColor = .white
        
        postLabel.numberOfLines = 0
        postLabel.font = Constants.postLabelFont
        postLabel.textColor = .black
        
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        nameLabel.numberOfLines = 0
        nameLabel.textColor = .black
        
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        dateLabel.numberOfLines = 0
        dateLabel.textColor = .gray
        
        likesImage.image = UIImage(named: "like")
        commentsImage.image = UIImage(named: "comment")
        sharesImage.image = UIImage(named: "share")
        viewsImage.image = UIImage(named: "eye")
  
        likesLabel.textColor = #colorLiteral(red: 0.5768421292, green: 0.6187390685, blue: 0.664434731, alpha: 1)
        likesLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        likesLabel.lineBreakMode = .byClipping
   
        commentsLabel.textColor = #colorLiteral(red: 0.5768421292, green: 0.6187390685, blue: 0.664434731, alpha: 1)
        commentsLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        commentsLabel.lineBreakMode = .byClipping
  
        sharesLabel.textColor = #colorLiteral(red: 0.5768421292, green: 0.6187390685, blue: 0.664434731, alpha: 1)
        sharesLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        sharesLabel.lineBreakMode = .byClipping
   
        viewsLabel.textColor = #colorLiteral(red: 0.5768421292, green: 0.6187390685, blue: 0.664434731, alpha: 1)
        viewsLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        viewsLabel.lineBreakMode = .byClipping
    }
    
    func addSubviews() {
        
        cardView.translatesAutoresizingMaskIntoConstraints = false
        topView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(cardView)
    
        cardView.addSubview(topView)
        cardView.addSubview(postLabel)
        cardView.addSubview(postImageView)
        cardView.addSubview(bottomView)
        
        [iconImageView, nameLabel, dateLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            topView.addSubview($0)
        }
        
        [likesView, commentsView, sharesView, viewsView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            bottomView.addSubview($0)
        }
        
        [likesImage, likesLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            likesView.addSubview($0)
        }
        
        [commentsImage, commentsLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            commentsView.addSubview($0)
        }
        
        [sharesImage, sharesLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            sharesView.addSubview($0)
        }
        
        [viewsImage, viewsLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            viewsView.addSubview($0)
        }
    }
    
    func makeConstraints() {
        cardView.fillSuperview(padding: Constants.cardInsets)
        NSLayoutConstraint.activate([
            // topView
            topView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8),
            topView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -8),
            topView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 8),
            topView.heightAnchor.constraint(equalToConstant: Constants.topViewHeight),
            
            // iconImageView
            iconImageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            iconImageView.topAnchor.constraint(equalTo: topView.topAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: Constants.topViewHeight),
            iconImageView.widthAnchor.constraint(equalToConstant: Constants.topViewHeight),
            
            // nameLabel
            nameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: 8),
            nameLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 2),
            nameLabel.heightAnchor.constraint(equalToConstant: Constants.topViewHeight / 2 - 2),
            
            // dateLabel
            dateLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8),
            dateLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -8),
            dateLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -2),
            dateLabel.heightAnchor.constraint(equalToConstant: 14),
            
            // likesView
            likesView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor),
            likesView.topAnchor.constraint(equalTo: bottomView.topAnchor),
            likesView.widthAnchor.constraint(equalToConstant: Constants.bottomViewViewWidth),
            likesView.heightAnchor.constraint(equalToConstant: Constants.bottomViewViewHeight),
            
            // commentsView
            commentsView.leadingAnchor.constraint(equalTo: likesView.trailingAnchor),
            commentsView.topAnchor.constraint(equalTo: bottomView.topAnchor),
            commentsView.widthAnchor.constraint(equalToConstant: Constants.bottomViewViewWidth),
            commentsView.heightAnchor.constraint(equalToConstant: Constants.bottomViewViewHeight),
            
            // sharesView
            sharesView.leadingAnchor.constraint(equalTo: commentsView.trailingAnchor),
            sharesView.topAnchor.constraint(equalTo: bottomView.topAnchor),
            sharesView.widthAnchor.constraint(equalToConstant: Constants.bottomViewViewWidth),
            sharesView.heightAnchor.constraint(equalToConstant: Constants.bottomViewViewHeight),
            
            // viewsView
            viewsView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor),
            viewsView.topAnchor.constraint(equalTo: bottomView.topAnchor),
            viewsView.widthAnchor.constraint(equalToConstant: Constants.bottomViewViewWidth),
            viewsView.heightAnchor.constraint(equalToConstant: Constants.bottomViewViewHeight)
        ])
        
        helpInFourthLayer(view: likesView, imageView: likesImage, label: likesLabel)
        helpInFourthLayer(view: commentsView, imageView: commentsImage, label: commentsLabel)
        helpInFourthLayer(view: sharesView, imageView: sharesImage, label: sharesLabel)
        helpInFourthLayer(view: viewsView, imageView: viewsImage, label: viewsLabel)
    }
    
    func helpInFourthLayer(view: UIView, imageView: UIImageView, label: UILabel) {
        NSLayoutConstraint.activate([
            // imageView
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            imageView.widthAnchor.constraint(equalToConstant: Constants.bottomViewViewsIconSize),
            imageView.heightAnchor.constraint(equalToConstant: Constants.bottomViewViewsIconSize),
            
            // label
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 4),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
 
