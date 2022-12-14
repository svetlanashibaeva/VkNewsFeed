//
//  NewsfeedWorker.swift
//  VkNewsFeed
//
//  Created by Света Шибаева on 23.11.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class NewsfeedService {
    
    private let authService: AuthService
    private let networking: Networking
    private let fetcher: DataFetcher
    
    private var revealedPostIds = [Int]()
    private var feedResponse: FeedResponse?
    private var newFromInProcess: String?
    
    init() {
        authService = SceneDelegate.shared().authService
        networking = NetworkService(authService: authService)
        fetcher = NetworkDataFetcher(networking: networking)
    }
    
    func getUser(completion: @escaping (UserResponse?) -> Void) {
        fetcher.getUser { userResponse in
            completion(userResponse)
        }
    }
    
    func getFeed(completion: @escaping ([Int], FeedResponse) -> Void) {
        fetcher.getFeed(nextBatchFrom: nil) { [weak self] feed in
            guard let self = self else { return }
            
            self.feedResponse = feed
            guard let feedResponse = self.feedResponse else { return }
            completion(self.revealedPostIds, feedResponse)
        }
    }
    
    func revealPostIds(forPostId postId: Int, completion: @escaping ([Int], FeedResponse) -> Void) {
        revealedPostIds.append(postId)
        guard let feedResponse = feedResponse else { return }
        completion(revealedPostIds, feedResponse)
    }
    
    func getNextBatch(completion: @escaping ([Int], FeedResponse) -> Void) {
        newFromInProcess = feedResponse?.nextFrom
        
        fetcher.getFeed(nextBatchFrom: newFromInProcess) { [weak self] feed in
            guard let self = self, let feed = feed else { return }
            guard self.feedResponse?.nextFrom != feed.nextFrom else { return }
            
            if self.feedResponse == nil {
                self.feedResponse = feed
            } else {
                self.feedResponse?.items.append(contentsOf: feed.items)
                self.feedResponse?.nextFrom = feed.nextFrom
                
                var profiles = feed.profiles
                if let oldProfiles = self.feedResponse?.profiles {
                    let oldProfilesFiltered = oldProfiles.filter { (oldProfile) -> Bool in
                        !feed.profiles.contains(where: { $0.id == oldProfile.id})
                    }
                    profiles.append(contentsOf: oldProfilesFiltered)
                }
                self.feedResponse?.profiles = profiles
                
                var groups = feed.groups
                if let oldGroups = self.feedResponse?.groups {
                    let oldGroupsFiltered = oldGroups.filter { (oldGroup) -> Bool in
                        !feed.groups.contains(where: { $0.id == oldGroup.id})
                    }
                    groups.append(contentsOf: oldGroupsFiltered)
                }
                self.feedResponse?.groups = groups
            }
            
            guard let feedResponse = self.feedResponse else { return }
            completion(self.revealedPostIds, feedResponse)
        }
    }
}
