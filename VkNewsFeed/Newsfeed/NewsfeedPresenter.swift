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
        case .some:
            print(".some Presenter")
        case .presentNewsfeed:
            print(".presentNewsfeed Presenter")
            viewController?.displayData(viewModel: .displayNewsfeed)
        }
    }
    
}
