//
//  FeedViewModel.swift
//  EssentialFeediOS
//
//  Created by Pawel Klapuch on 4/30/23.
//

import Foundation
import EssentialFeed

final class FeedViewModel {
    private let feedLoader: FeedLoader
    
    var onChanged: ((FeedViewModel) -> Void)?
    var onFeedLoad: (([FeedImage]) -> Void)?
    
    init(feedLoader: FeedLoader) {
        self.feedLoader = feedLoader
    }
    
    private(set) var isLoading: Bool = false {
        didSet { onChanged?(self) }
    }
    
    func loadFeed() {
        isLoading = true
        feedLoader.load { [weak self] result in
            if let feed = try? result.get() {
                self?.onFeedLoad?(feed)
            }
            
            self?.isLoading = false
        }
    }
}
