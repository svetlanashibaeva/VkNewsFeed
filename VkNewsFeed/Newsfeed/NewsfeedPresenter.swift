//
//  NewsfeedPresenter.swift
//  VkNewsFeed
//
//  Created by Света Шибаева on 23.11.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsfeedPresentationLogic {
    func presentData(response: Newsfeed.Model.Response.ResponseType)
}

class NewsfeedPresenter: NewsfeedPresentationLogic {
    weak var viewController: NewsfeedDisplayLogic?
    var cellLayoutCalculator: FeedCellLayoutCalculatorProtocol = NewsfeedCellLayoutCalculator()
    
    let dateFormatter: DateFormatter = {
        let dt = DateFormatter()
        dt.locale = Locale(identifier: "ru_RU")
        dt.dateFormat = "d MMM 'в' HH:mm"
        return dt
    }()
    
    func presentData(response: Newsfeed.Model.Response.ResponseType) {
        switch response {
        case .presentNewsfeed(feed: let feed, let revealedPostIds):
            
            let cells = feed.items.map{ feedItem in
                cellViewModel(
                    from: feedItem,
                    profiles: feed.profiles,
                    groups: feed.groups,
                    revealedPostIds: revealedPostIds
                )
            }
            
            let feedViewModel = FeedViewModel(cells: cells)
            viewController?.displayData(viewModel: .displayNewsfeed(feedViewModel: feedViewModel))
        }
    }
    
    private func cellViewModel(from feedItem: FeedItem, profiles: [Profile], groups: [Group], revealedPostIds: [Int]) -> FeedViewModel.Cell {
        
        let profile = self.profile(for: feedItem.sourceId, profiles: profiles, groups: groups)
        let photoAttachments = self.photoAttachements(feedItem: feedItem)
        let date = Date(timeIntervalSince1970: feedItem.date)
        let dateTitle = dateFormatter.string(from: date)
        
        let isFullSizes = revealedPostIds.contains(feedItem.postId)
        
        let sizes = cellLayoutCalculator.sizes(
            postText: feedItem.text,
            photoAttachments: photoAttachments,
            isFullSizedPost: isFullSizes
        )

        return FeedViewModel.Cell(
            postId: feedItem.postId,
            iconUrlString: profile.photo,
            name: profile.name,
            date: dateTitle,
            text: feedItem.text,
            likes: String(feedItem.likes?.count ?? 0),
            comments: String(feedItem.comments?.count ?? 0),
            shares: String(feedItem.reposts?.count ?? 0),
            views: String(feedItem.views?.count ?? 0),
            photoAttachments: photoAttachments,
            sizes: sizes
        )
    }
    
    private func profile(for sourceId: Int, profiles: [Profile], groups: [Group]) -> ProfileRepresenatable {
         let profilesOrGroups: [ProfileRepresenatable] = sourceId >= 0 ? profiles : groups
         let normalSourceId = sourceId >= 0 ? sourceId : -sourceId
         let profileRepresenatable = profilesOrGroups.first { (myProfileRepresenatable) -> Bool in
             myProfileRepresenatable.id == normalSourceId
         }
         
         return profileRepresenatable!
     }
    
    private func photoAttachement(feedItem: FeedItem) -> FeedViewModel.FeedCellPhotoAttachment? {
        guard let photos = feedItem.attachments?.compactMap({ attachment in
            attachment.photo
        }), let firstPhoto = photos.first else { return nil }
        
        return FeedViewModel.FeedCellPhotoAttachment(
            photoUrlString: firstPhoto.srcBig,
            width: firstPhoto.width,
            height: firstPhoto.height
        )
    }
    
    private func photoAttachements(feedItem: FeedItem) -> [FeedViewModel.FeedCellPhotoAttachment] {
        guard let attachments = feedItem.attachments else { return [] }
        return attachments.compactMap({ (attachment) -> FeedViewModel.FeedCellPhotoAttachment? in
            guard let photo = attachment.photo else { return nil }
            return FeedViewModel.FeedCellPhotoAttachment.init(
                photoUrlString: photo.srcBig,
                width: photo.width,
                height: photo.height
            )
        })
    }
    
}
