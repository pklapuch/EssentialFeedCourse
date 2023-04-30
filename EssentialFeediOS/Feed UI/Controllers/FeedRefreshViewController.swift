//
//  FeedRefreshViewController.swift
//  EssentialFeediOS
//
//  Created by Pawel Klapuch on 4/30/23.
//

import UIKit

final class FeedRefreshViewController: NSObject {
    private(set) lazy var view: UIRefreshControl = binded(UIRefreshControl())
    private let viewModel: FeedViewModel
    
    init(viewModel: FeedViewModel) {
        self.viewModel = viewModel
    }
    
    func refresh() {
        load()
    }
    
    @objc private func load() {
        view.beginRefreshing()
        viewModel.onChanged = { [weak self] viewModel in
            if viewModel.isLoading {
                self?.view.beginRefreshing()
            } else {
                self?.view.endRefreshing()
            }
        }
        
        viewModel.loadFeed()
    }
    
    private func binded(_ view: UIRefreshControl) -> UIRefreshControl {
        viewModel.onChanged = { viewModel in
            if viewModel.isLoading {
                view.beginRefreshing()
            } else {
                view.endRefreshing()
            }
        }
        
        view.addTarget(self, action: #selector(load), for: .valueChanged)
        
        return view
    }
}
