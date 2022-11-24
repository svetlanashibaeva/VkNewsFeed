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
    
    func presentData(response: Newsfeed.Model.Response.ResponseType) {
        switch response {
        case .presentNewsfeed(feed: let feed):
            
            let cells = feed.items.map{ feedItem in
                cellViewModel(from: feedItem)
            }
            
            let feedViewModel = FeedViewModel(cells: cells)
            viewController?.displayData(viewModel: .displayNewsfeed(feedViewModel: feedViewModel))
        }
        
        func cellViewModel(from feedItem: FeedItem) -> FeedViewModel.Cell {
            return FeedViewModel.Cell(
                iconUrlString: "",
                name: "name",
                date: "date",
                text: feedItem.text,
                likes: String(feedItem.likes?.count ?? 0),
                comments: String(feedItem.comments?.count ?? 0),
                shares: String(feedItem.reposts?.count ?? 0),
                views: String(feedItem.views?.count ?? 0)
            )
        }
    }
    
}
