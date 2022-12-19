//
//  NewsfeedViewController.swift
//  VkNewsFeed
//
//  Created by Света Шибаева on 23.11.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsfeedDisplayLogic: AnyObject {
    func displayData(viewModel: Newsfeed.Model.ViewModel.ViewModelData)
}

final class NewsfeedViewController: UIViewController, NewsfeedDisplayLogic {
    
    @IBOutlet weak var tableView: UITableView!
    
    var interactor: NewsfeedBusinessLogic?
    
    private var feedViewModel = FeedViewModel(cells: [], footerTitle: nil)
    
    private let titleView = TitleView()
    private lazy var footerView = FooterView()
    
    private var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(NewsfeedViewController.self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupTable()
        setupTopBars()
        
        interactor?.makeRequest(request: .getNewsfeed)
        interactor?.makeRequest(request: .getUser)
    }
      
    @objc func refresh() {
        interactor?.makeRequest(request: .getNewsfeed)
    }
    
    func displayData(viewModel: Newsfeed.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case let .displayNewsfeed(feedViewModel):
            self.feedViewModel = feedViewModel
            footerView.setTitle(feedViewModel.footerTitle)
            tableView.reloadData()
            refreshControl.endRefreshing()
        case let .displayUser(userViewModel):
            titleView.set(userViewModel: userViewModel)
        case .diaplayFooterLoader:
            footerView.showLoader()
        }
    }
}

// MARK: Setup
private extension NewsfeedViewController {
    
    func setup() {
        let interactor = NewsfeedInteractor()
        let presenter = NewsfeedPresenter()
        self.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = self
    }

    func setupTable() {
        tableView.contentInset.top = 8
        tableView.register(NewsfeedCodeCell.self, forCellReuseIdentifier: NewsfeedCodeCell.reuseId)
        
        tableView.addSubview(refreshControl)
        tableView.tableFooterView = footerView
    }
    
    func setupTopBars() {
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.titleView = titleView
    }
}

extension NewsfeedViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellViewModel = feedViewModel.cells[indexPath.row]
        return cellViewModel.sizes.totalHeight
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellViewModel = feedViewModel.cells[indexPath.row]
        return cellViewModel.sizes.totalHeight
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y > scrollView.contentSize.height / 2 {
            interactor?.makeRequest(request: .getNextBatch)
        }
    }
}

extension NewsfeedViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedViewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsfeedCodeCell.reuseId, for: indexPath) as! NewsfeedCodeCell
        let cellViewModel = feedViewModel.cells[indexPath.row]
        cell.set(viewModel: cellViewModel)
        cell.delegate = self
        return cell
    }
}

extension NewsfeedViewController: NewsfeedCodeCellDelegate {
    
    func revealPost(for cell: NewsfeedCodeCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let cellViewModel = feedViewModel.cells[indexPath.row]
        
        interactor?.makeRequest(request: .revealPostIds(postId: cellViewModel.postId))
    }
}
