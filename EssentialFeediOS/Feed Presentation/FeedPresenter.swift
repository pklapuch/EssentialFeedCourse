//
//  FeedPresenter.swift
//  EssentialFeediOS
//
//  Created by Pawel Klapuch on 5/1/23.
//

import Foundation
import EssentialFeed

protocol FeedLoadingView {
    func dispaly(isLoading: Bool)
}

protocol FeedView {
    func display(feed: [FeedImage])
}

final class FeedPresenter {
    private let feedLoader: FeedLoader
    
    var feedView: FeedView?
    var loadingView: FeedLoadingView?
    
    init(feedLoader: FeedLoader) {
        self.feedLoader = feedLoader
    }
    
    func loadFeed() {
        loadingView?.dispaly(isLoading: true)
        feedLoader.load { [weak self] result in
            if let feed = try? result.get() {
                self?.feedView?.display(feed: feed)
            }
            
            self?.loadingView?.dispaly(isLoading: false)
        }
    }
}
