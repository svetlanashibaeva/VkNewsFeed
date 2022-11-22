//
//  FeedViewController.swift
//  VkNewsFeed
//
//  Created by Света Шибаева on 22.11.2022.
//

import Foundation
import UIKit

class FeedViewController: UIViewController {
    
    let networkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkService.getFeed()
        view?.backgroundColor = .blue
    }
}
