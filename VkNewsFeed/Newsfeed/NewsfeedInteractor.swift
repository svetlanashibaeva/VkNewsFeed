//
//  NewsfeedInteractor.swift
//  VkNewsFeed
//
//  Created by Света Шибаева on 23.11.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsfeedBusinessLogic {
    func makeRequest(request: Newsfeed.Model.Request.RequestType)
}

final class NewsfeedInteractor: NewsfeedBusinessLogic {
    
    var presenter: NewsfeedPresentationLogic?
    
    private let service = NewsfeedService()
    
    func makeRequest(request: Newsfeed.Model.Request.RequestType) {
        
        switch request {
        case .getNewsfeed:
            service.getFeed(completion: { [weak self] revealedPostIds, feed in
                self?.presenter?.presentData(response: .presentNewsfeed(feed: feed, revealedPostIds: revealedPostIds))
            })
            
        case .getUser:
            service.getUser(completion: { [weak self] user in
                self?.presenter?.presentData(response: .presentUserInfo(user: user))
            })
            
        case let .revealPostIds(postId):
            service.revealPostIds(forPostId: postId, completion: { [weak self] revealedPostIds, feed in
                self?.presenter?.presentData(response: .presentNewsfeed(feed: feed, revealedPostIds: revealedPostIds))
            })
            
        case .getNextBatch:
            presenter?.presentData(response: .presentFooterLoader)
            service.getNextBatch(completion: { [weak self] revealedPostIds, feed in
                self?.presenter?.presentData(response: .presentNewsfeed(feed: feed, revealedPostIds: revealedPostIds))
            })
        }
    }
}
